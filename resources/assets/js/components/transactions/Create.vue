<template>
    <div>
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Tambah Transaksi</h1>
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
                             
                               <detail-form v-for="(item,index) in transactionDetails" v-bind:key="index" v-bind:index="index"
                               v-on:delete-row="deleteItem(index)" v-on:selected="selectedProducts"></detail-form>

                             
                            </div>

                            <div class="card-footer">
                              <button type="button" class="btn btn-success" v-on:click="addItem()">
                                <i class="fa fa-plus"></i> Tambah item
                              </button>
                              <button type="submit" class="btn btn-primary">
                                <i v-if="pending"  class="fa fa-refresh fa-spin"></i>Submit
                              </button>
                              <div class="float-right"><strong>Total : {{ "Rp."+total_price.toLocaleString('en-IND') }}</strong></div>
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
              total_price: 0,
              transactionDetails : [{}],
              config:{
                    headers: {
                        'Content-Type': 'application/json' ,
                        'Authorization' : 'Bearer '+ localStorage.getItem("token"),
                    },
                },
            };
          },

          methods:{
            store(){
              this.pending = true;
                axios.post('/api/transactions',this.transactionDetails,this.config)
                .then(({data}) => {
                    if(data.error == false){
                         this.$store.dispatch("success", data.message).then(() => {                            
                             this.$router.push("/transactions")
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
            },

            addItem() {
              this.transactionDetails.push({});
            },

            deleteItem(index) {
              if(index > 0){
                this.transactionDetails.splice(index, 1);
              }
              this.recalculateTotalPrice()
            },

            selectedProducts(index,product_data){
              this.transactionDetails[index] = product_data;
              this.recalculateTotalPrice()
            },

            recalculateTotalPrice(){
              this.total_price = 0;
              for (let i = 0; i < this.transactionDetails.length; i++) {
                this.total_price += this.transactionDetails[i].sub_price
              }
            }
          }
        
                  

    }
</script>
