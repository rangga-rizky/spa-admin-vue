<template>
    <div>
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Edit Transaksi</h1>
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

                        <form role="form" @submit.prevent="update()">
                            <div class="card-body">
                              <div class="form-group">
                                <label for="total_price">Total Harga : </label>
                                <input type="number" class="form-control" v-model="total_price" id="total_price" placeholder="Masukan Total Harga" required="">
                              </div>
                              <div class="form-group">
                                <label for="total_amount">Jumlah produk :</label>
                                <input type="number" v-model="total_amount" class="form-control" id="total_amount" placeholder="Masukan Jumlah produk" required="">
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
              total_amount : 0,
              total_price : 0,
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

        methods:{
            fetch(){
              axios.get('/api/transactions/'+this.id,this.config)
              .then(({data}) => {
                this.total_amount=data.total_amount;
                this.total_price=data.total_price;
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
                axios.put('/api/transactions/'+this.id,{
                    total_amount:this.total_amount,
                    total_price:this.total_price,
                    unit:this.unit
                },this.config)
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
            }               

        }

    }
</script>
