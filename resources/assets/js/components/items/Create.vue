<template>
    <div>
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Tambah Barang</h1>
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

                        <form role="form" @submit.prevent="store({name,stock,unit})">
                            <div class="card-body">
                              <div class="form-group">
                                <label for="name">Nama Barang : </label>
                                <input class="form-control" v-model="name" id="name" placeholder="Masukan Nama Barang" required="">
                              </div>
                              <div class="form-group">
                                <label for="stock">Stok :</label>
                                <input type="number" v-model="stock" class="form-control" id="stock" placeholder="Masukan Jumlah Stok" required="">
                              </div>
                               <div class="form-group">
                                <label for="unit">Satuan : </label>
                                <input class="form-control"v-model="unit"  id="unit" placeholder="Masukan Tipe Satuan" required="">
                              </div>
                            </div>

                            <div class="card-footer">
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
              name : "",
              stock : 0,
              unit:"",
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
                axios.post('/api/items',{
                    name:this.name,
                    stock:this.stock,
                    unit:this.unit
                },this.config)
                .then(({data}) => {
                    if(data.error == false){
                         this.$store.dispatch("success", data.message).then(() => {                            
                             this.$router.push("/items")
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
