<template>
    <div>
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Tambah Item Produk</h1>
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

                        <form role="form" @submit.prevent="store()">
                            <div class="card-body">
                              <div class="form-group">
                                <label for="product">Product : </label>
                                <select class="form-control" id="product" v-model="selectedProduct" required="">
                                  <option v-for="product in products" v-bind:value="product.id">
                                    {{ product.name }}
                                  </option>
                                </select>
                               </div>    
                               <item-option v-for="(item,index) in itemProducts" v-bind:key="index" v-bind:index="index"
                               v-on:delete-row="deleteItem(index)" v-on:selected="selectedItem"></item-option>

                             
                            </div>

                            <div class="card-footer">
                              <button type="button" class="btn btn-success" v-on:click="addItem()">
                                <i class="fa fa-plus"></i> Tambah item
                              </button>
                              <button type="submit" class="btn btn-primary">
                                <i v-if="pending"  class="fa fa-refresh fa-spin"></i>Submit
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

        data() {
            return {
              pending:false,
              products : [],
              selectedProduct : "",
              itemProducts : [{}],
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
        },

        methods:{   

          fetchProduct(){
             axios.get('/api/products/array',this.config)
              .then(({data}) => {
                this.products=data;
                this.selectedProduct=data[0].id;
               // console.log(data);
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

          addItem() {
            this.itemProducts.push({});
          },

          deleteItem(index) {
            if(index > 0){
              this.itemProducts.splice(index, 1);
            }
          },

          selectedItem(index,item_data){
            item_data.product_id = this.selectedProduct;
            //console.log(item_data);
            this.itemProducts[index] = item_data;
          },

          store(){
            this.pending = true;
                axios.post('/api/product-items',this.itemProducts,this.config)
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

      }            

    }
</script>
