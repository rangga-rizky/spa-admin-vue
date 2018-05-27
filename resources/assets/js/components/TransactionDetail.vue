<template>
	<div>
		<!-- Content Header (Page header) -->
		<div class="content-header">
			<div class="container-fluid">
				<div class="row mb-2">
					<div class="col-sm-6">
						<h1 class="m-0 text-dark">Detail Transaksi</h1>
					</div><!-- /.col -->
				</div><!-- /.row -->
			</div><!-- /.container-fluid -->
		</div>
		<!-- /.content-header -->

		<!-- Main content -->
		<section class="content">
			<div class="container-fluid">
				<!-- Small boxes (Stat box) -->
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-header">
								<strong>ID Transaksi : </strong>{{transaction.id}}	<br>
								<strong>User : </strong>{{transaction.user}}	<br>
								<strong>Total Price : </strong>{{"Rp."+transaction.total_price.toLocaleString('en-IND')}}								
							</div>
							<div class="card-body">
								<table id="example2" class="table table-bordered table-hover">
									<thead>
										<tr>
											<th>id</th>
											<th>Produk</th>
											<th>Sub Total</th>											
											<th>Qty</th>
											<th>Total Harga</th>
											<th>Created at</th>
											<th>Updated at</th>
											<th>Aksi</th>
										</tr>
									</thead>
									<tbody>
										<tr v-for="(transactionDetail, index) in transactionDetails"  v-bind:key="transactionDetail.id" >
											<td>{{ transactionDetail.id }}</td>
											<td>{{ transactionDetail.product }}</td>
											<td>{{ "Rp."+transactionDetail.sub_price.toLocaleString('en-IND') }}</td>
											<td>{{ transactionDetail.qty }}</td>											
											<td>{{ "Rp."+transactionDetail.price.toLocaleString('en-IND') }}</td>
											<td>{{ transactionDetail.created_at }}</td>
											<td>{{ transactionDetail.updated_at }}</td>
											<td>
												<button v-on:click="destroy(transactionDetail.id,index)" type="button" class="btn btn-outline-danger">
													<i v-if="pending"  class="fa fa-refresh fa-spin"></i>
													<i v-if="!pending" class="fa fa-trash"></i>
												</button>
											</td>
										</tr>										
									</tbody>
									<tfoot>
									</tfoot>
								
								</table>
							</div>
						</div>
					</div>
				</div>
				<!-- /.row -->
			</div><!-- /.container-fluid -->
		</section>
		<!-- /.content -->
	</div>
</template>
<script>
    export default {
  		
  		props: {
          id: {
              type: Number,
              required: true,
          },
        },

    	 data() {
		    return {
		      transaction:{},
		      transactionDetails:[],
		      pending:false,
		      config:{
        			headers: {
        				'Content-Type': 'application/json' ,
        				'Authorization' : 'Bearer '+ localStorage.getItem("token"),
        			},
       			},
		    };
		  },

		  created() {
		  	console.log(this.config);
		  	this.transaction.total_price = 0;
		    this.fetch();
		  },

		  methods: {
		    fetch() {
		    	axios.get('/api/transaction-details/transaction/'+this.id,this.config)
			        .then(({data}) => {
				        this.transactionDetails = data.data;
				        this.transaction = data.meta;
				      })
			        .catch((error) => {	     
					   if(error.response.status == 401){
					   	alert("Token Expired");
			            this.$store.dispatch('logout').then(() => {
					    	this.$router.push("/login");
					 	});
			           }else{			           	
			          		alert("Terjadi Kesalahan pada server");
			           } 
		        });  
		    },

		    destroy(id,index){
		    	if (confirm("Apakah Anda Yakin ?")) {				    
		    		this.pending = true;
		    		axios.delete('/api/transaction-details/'+id,this.config)
			        .then(({data}) => {
			        	if(data.error == false){
                         this.$store.dispatch("success", data.message).then(() => {                       
                             
			        		this.$delete(this.transactionDetails, index);
                          });                                            
	                    }else{
	                        alert(data.message);
	                    }
			        	this.pending = false;
				    })
			        .catch((error) => {	     
					   if(error.response.status == 401){
					   	alert("Token Expired");
			            this.$store.dispatch('logout').then(() => {
					    	this.$router.push("/login");
					 	});
			           }else{			           	
			          		alert("Terjadi Kesalahan pada server");
			           } 
			           this.pending = false;
		        });  
				}
		    }
		},

		computed: {
		    isSuccess(){
		      return this.$store.getters.isSuccess;
		    },
		     messages(){
		      return this.$store.getters.messages;
		    },
		}	


    }
</script>