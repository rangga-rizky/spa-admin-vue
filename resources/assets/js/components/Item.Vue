<template>
	<div>
		<!-- Content Header (Page header) -->
		<div class="content-header">
			<div class="container-fluid">
				<div class="row mb-2">
					<div class="col-sm-6">
						<h1 class="m-0 text-dark">Daftar barang</h1>
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
								<div class="row">			  
								<div class="col-2">
									<router-link  :to="{ name: 'item-create'}" class="btn btn-primary" > <span class="fa fa-plus"></span>
        							Tambah Data
        					    </router-link>
								</div>
								<div class="col-5">
									<div class="input-group input-group-sm">
							        <input class="form-control" v-model="search" type="search" placeholder="Search" aria-label="Search">
							        <div class="input-group-append">
							          <button class="btn" type="button" @click="searchData">
							            <i class="fa fa-search"></i>
							          </button>
							        </div>
							        </div>
								</div>       						
        					     </div>	
							</div>
							<div class="card-body">
								<table id="example2" class="table table-bordered table-hover">
									<thead>
										<tr>
											<th>id</th>
											<th>Nama</th>
											<th>Stok</th>
											<th>Unit</th>
											<th>Last updated by</th>
											<th>Created at</th>
											<th>Updated at</th>
											<th>Aksi</th>
										</tr>
									</thead>
									<tbody>
										<tr v-for="(item, index) in items"  v-bind:key="item.id" >
											<td>{{ item.id }}</td>
											<td>{{ item.name }}</td>
											<td>{{ item.stock }}</td>
											<td>{{ item.unit }}</td>
											<td>{{ item.last_updated_by }}</td>
											<td>{{ item.created_at }}</td>
											<td>{{ item.updated_at }}</td>
											<td>
												<router-link  :to="{ name: 'item-edit', params: {id:item.id}}"  class="btn btn-outline-success">
													<i class="fa fa-edit"></i>
												</router-link>
												<button v-on:click="destroy(item.id,index)" type="button" class="btn btn-outline-danger">
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
		props: ['id_notif'],
    	data() {
		    return {
		      paginator: {},
		      items:[],
		      search: "",
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
				let readNotif = "";
				if(this.id_notif !== undefined){
					readNotif = "&read="+this.id_notif;
				}
		    	axios.get('/api/items?page='+this.paginator.current_page+readNotif,this.config)
			        .then(({data}) => {
			        	//console.log(data);
				        this.paginator = data.paginator;
				        this.items = data.data;
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

		    searchData(){
		    	if(this.search.length > 0){		    	
			    	axios.get('/api/items/search/'+this.search+'?page='+this.paginator.current_page,this.config)
				        .then(({data}) => {
					        this.paginator = data.paginator;
					        this.items = data.data;
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
			    }else{
			    	this.fetch();
			    }
		    },

		    destroy(id,index){
		    	if (confirm("Apakah Anda Yakin ?")) {				    
		    		this.pending = true;
		    		axios.delete('/api/items/'+id,this.config)
			        .then(({data}) => {
			        	if(data.error == false){
                         this.$store.dispatch("success", data.message).then(() => {                        
                             
			        		this.$delete(this.items, index);
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