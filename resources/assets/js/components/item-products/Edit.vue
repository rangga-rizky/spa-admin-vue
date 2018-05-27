<template>
    <div>
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Edit Item Produk</h1>
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content-header -->

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="card card-primary">

                        <form role="form" @submit.prevent="update({selectedProduct,selectedItem,qty})">
                            <div class="card-body">
                              <div class="form-group">
                                <label for="product">Product : </label>
                                <select class="form-control" id="product" v-model="selectedProduct">
                                  <option v-for="product in products" v-bind:value="product.id">
                                    {{ product.name }}
                                  </option>
                                </select>
                               </div>                              
                               <div class="form-group">
                                <label for="item">Item : </label>
                                 <select class="form-control" id="item" v-model="selectedItem">
                                      <option v-for="item in items" v-bind:value="item.id">
                                    {{ item.name }}
                                  </option>
                                </select>
                              </div>
                              <div class="form-group">
                                <label for="qty">Qty :</label>
                                <input type="number" v-model="qty" class="form-control" id="qty" placeholder="Masukan Jumlah Stok" required="">
                              </div>
                            </div>

                            <div class="card-footer">
                              <button type="submit" class="btn btn-primary">
                                <i v-if="pending"  class="fa fa-refresh fa-spin"></i>Update
                              </button>
                            </div>
                        </form>
                        </div>
                  </div>
              </div>
            </div>
        </section>

</div>
</template>

<script>
    export default {

        props: {
          id: {
              type: String,
              required: true,
          },
        },

        data() {
            return {
              pending:false,
              products : [],
              items : [],
              selectedProduct : "",
              selectedItem : "",
              qty:0,
              config:{
                    headers: {
                        'Content-Type': 'application/json' ,
                        'Authorization' : 'Bearer '+ localStorage.getItem("token"),
                    },
                },
            };
          },
        
        created() {
          this.fetchProduct();
          this.fetchItem();
          this.fetch(this.id);
        },

        methods:{   

          fetch(){
              axios.get('/api/product-items/'+this.id,this.config)
              .then(({data}) => {
                this.selectedItem=data.item_id;
                this.selectedProduct=data.product_id;
                this.qty=data.qty;
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

          fetchProduct(){
             axios.get('/api/products/array',this.config)
              .then(({data}) => {
                this.products=data;
                console.log(data);
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

          fetchItem(){
             axios.get('/api/items/array',this.config)
              .then(({data}) => {
                this.items=data;
                console.log(data);
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


            update(){
                this.pending = true;
                axios.put('/api/product-items/'+this.id,{
                    item_id:this.selectedItem,
                    product_id:this.selectedProduct,
                    qty:this.qty
                },this.config)
                .then(({data}) => {
                    if(data.error == false){
                         this.$store.dispatch("success", data.message).then(() => {                            
                             this.$router.push("/item-products")
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
        },

    }
</script>
