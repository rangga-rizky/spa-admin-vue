<template>
	<div>
		<!-- Content Header (Page header) -->
		<div class="content-header">
			<div class="container-fluid">
				<div class="row mb-2">
					<div class="col-sm-6">
						<h1 class="m-0 text-dark">Daftar Transaksi</h1>
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
						  <div v-if="isSuccess" class="alert alert-success alert-dismissible">
						  	<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
					          <strong>Berhasil!</strong> {{messages}}
					        </div>
						<div class="card">
							<div class="card-header">								  
        						<router-link  :to="{ name: 'transaction-create'}" class="btn btn-primary" > <span class="fa fa-plus"></span>
        							Tambah Data
        					    </router-link>
							</div>
							<div class="card-body">
								<table id="example2" class="table table-bordered table-hover">
									<thead>
										<tr>
											<th>id</th>
											<th>Total Harga</th>
											<th>Qty</th>
											<th>User</th>
											<th>Created at</th>
											<th>Updated at</th>
											<th>Aksi</th>
										</tr>
									</thead>
									<tbody>
										<tr v-for="(transaction, index) in transactions"  v-bind:key="transaction.id" >
											<td>{{ transaction.id }}</td>
											<td>{{ "Rp."+transaction.total_price.toLocaleString('en-IND') }}</td>
											<td>{{ transaction.total_amount }}</td>
											<td>{{ transaction.user }}</td>
											<td>{{ transaction.created_at }}</td>
											<td>{{ transaction.updated_at }}</td>
											<td>
												<router-link :to="{ name: 'transaction-details', params: {id:transaction.id}}"  class="btn btn-outline-primary">
													<i class="fa fa-eye"></i>
												</router-link>
												<router-link  :to="{ name: 'transaction-edit', params: {id:transaction.id}}"  class="btn btn-outline-success">
													<i class="fa fa-edit"></i>
												</router-link>
												<button v-on:click="destroy(transaction.id,index)" type="button" class="btn btn-outline-danger">
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
							<!-- /.card-body -->
							<div class="card-footer">								
								<pagination v-bind:pagination="paginator"  @paginate="fetch()" ></pagination>
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
    	 data() {
		    return {
		      paginator: {},
		      transactions:[],
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
		    this.fetch();
		  },

		  methods: {
		    fetch() {
		    	axios.get('/api/transactions?page='+this.paginator.current_page,this.config)
			        .then(({data}) => {
			        	//console.log(data);
				        this.paginator = data.paginator;
				        this.transactions = data.data;
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
		    		axios.delete('/api/transactions/'+id,this.config)
			        .then(({data}) => {
			        	if(data.error == false){
                         this.$store.dispatch("success", data.message).then(() => {                        
                             
			        		this.$delete(this.transactions, index);
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