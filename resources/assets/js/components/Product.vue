<template>
	<div>
		<!-- Content Header (Page header) -->
		<div class="content-header">
			<div class="container-fluid">
				<div class="row mb-2">
					<div class="col-sm-6">
						<h1 class="m-0 text-dark">Daftar Produk</h1>
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
        						<router-link  :to="{ name: 'product-create'}" class="btn btn-primary" > <span class="fa fa-plus"></span>
        							Tambah Data
        					    </router-link>
							</div>
							<div class="card-body">
								<table id="example2" class="table table-bordered table-hover">
									<thead>
										<tr>
											<th>id</th>
											<th>gambar</th>
											<th>Nama</th>
											<th>Harga</th>
											<th>Deskripsi</th>
											<th>Last updated by</th>
											<th>last update</th>
											<th>Aksi</th>
										</tr>
									</thead>
									<tbody>
										<tr v-for="(product, index) in products"  v-bind:key="product.id" >
											<td>{{ product.id }}</td>
											<td >
												<img v-if="product.small_image_path" :src="product.small_image_path" width="100" height="100" >
											</td>
											<td>{{ product.name }}</td>
											<td>{{ "Rp."+product.price.toLocaleString('en-IND') }}</td>
											<td>{{ product.description }}</td>
											<td>{{ product.last_updated_by }}</td>
											<td>{{ product.updated_at }}</td>
											<td>
												<router-link  :to="{ name: 'product-edit', params: {id:product.id}}"  class="btn btn-outline-success">
													<i class="fa fa-edit"></i>
												</router-link>
												<button v-on:click="destroy(product.id,index)" type="button" class="btn btn-outline-danger">
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
		      products:[],
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
		    	axios.get('/api/products?page='+this.paginator.current_page,this.config)
			        .then(({data}) => {
			        	//console.log(data);
				        this.paginator = data.paginator;
				        this.products = data.data;
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
		    		axios.delete('/api/products/'+id,this.config)
			        .then(({data}) => {
			        	if(data.error == false){
                         this.$store.dispatch("success", data.message).then(() => {                        
                             
			        		this.$delete(this.products, index);
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