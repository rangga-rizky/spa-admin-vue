<template>
    <div>
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Tambah Produk</h1>
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

                        <form enctype="multipart/form-data" role="form" @submit.prevent="store({name,price,description,image})">
                            <div class="card-body">
                              <div class="form-group">
                                <label for="name">Nama Barang : </label>
                                <input class="form-control" v-model="name" id="name" placeholder="Masukan Nama Barang" required="">
                              </div>
                              <div class="form-group">
                                <label for="price">Harga :</label>
                                <input type="number" v-model="price" class="form-control" id="price" placeholder="Masukan Harga" required="">
                              </div>
                               <div class="form-group">
                                <label for="description">Deskripsi : </label>
                                <input class="form-control"v-model="description"  id="description" placeholder="Deskripsi dari produk" >
                              </div>
                               <div v-if="!image" class="form-group">
                                <label for="image">Upload Gambar : </label>
                                  <div class="dropbox">
                                    <input type="file" id="image"  @change="onFileChange"
                                      accept="image/*" class="input-file" required="">
                                      <p v-if="checkIsInitial">
                                        Drag your file(s) here to begin<br> or click to browse
                                      </p>
                                  </div>
                              </div>
                              <div v-else>
                                <img :src="image" width="200" height="200" />
                                <button type="button" @click="removeImage">Remove image</button>
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
              isInitial:true,
              image: '',
              attachment:'',
              pending:false,
              name : "",
              price : 0,
              description:"",
              config:{
                    headers: {
                        'Authorization' : 'Bearer '+ localStorage.getItem("token"),
                        'Content-Type': 'multipart/form-data'
                    },
                },
            };
          },

        methods:{
            store(){
                this.pending = true;     
                var formData = new FormData();
                formData.append("images",this.attachment);   
                formData.append("name", this.name);           
                formData.append("price", this.price);   
                formData.append("description", this.description);   
                axios.post('/api/products',formData,this.config)
                .then(({data}) => {
                    if(data.error == false){
                         this.$store.dispatch("success", data.message).then(() => {                            
                             this.$router.push("/products")
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

            onFileChange(e) {
              var files = e.target.files || e.dataTransfer.files;
              if (!files.length)
                return;
              this.attachment=files[0];
              this.createImage(files[0]);
            },

            createImage(file) {
              var image = new Image();
              var reader = new FileReader();
              var vm = this;              
              this.isInitial = false;
              reader.onload = (e) => {
                vm.image = e.target.result;
              };
              reader.readAsDataURL(file);
            },

            removeImage: function (e) {
              this.image = '';
              this.isInitial = true;
            }
        },

        computed: {
          checkIsInitial() {
            return this.isInitial;
          },
        }

    }
</script>

