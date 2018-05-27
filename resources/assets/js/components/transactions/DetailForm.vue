<template>
    <div class="row">
       <div class="col-5">
          <div class="form-group">
               <label>Produk :</label>
               <autocomplete :suggestions="suggestions" v-model="selection" v-on:selected="selectedProduct">
</autocomplete>
          </div>
        </div> 
        <div class="col-2">
          <div class="form-group">
            <label for="price">Harga :</label>
            <input type="number" v-model="price" class="form-control" id="price"  required="" readonly="">
          </div>
        </div> 

         <div class="col-2">
          <div class="form-group">
            <label for="sub-price">Sub Total :</label>
            <input type="number" v-model="subPrice" class="form-control" id="sub-price"  required="" readonly="">
          </div>
        </div>

         <div class="col-2">
          <div class="form-group">
            <label for="price">Qty :</label>
            <input type="number" v-model="qty" class="form-control" id="qty"  @input="updateSubPrice()"  placeholder="Qty" required="" >
          </div>
        </div>

        <div class="col-1">
          <button style="margin-top: 30px" type="button" class="btn btn-danger"  @click="$emit('delete-row')">
            <i class="fa fa-trash"></i>
        </button>
        </div> 
    </div>
</template>

<script>
    export default {
      props: {
          index: {
              type: Number,
              required: true,
          },
         },

       data(){
          return {
            product_id:0,
            qty:0,
            price:0,
            subPrice:0,
            selection: '',
            suggestions: [],
            config:{
                    headers: {
                        'Content-Type': 'application/json' ,
                        'Authorization' : 'Bearer '+ localStorage.getItem("token"),
                    },
                },
          }
      },

      created(){
        this.fetchProduct();
      },

      methods:{  
        emitSelected(){
            this.$emit('selected',this.index, {"product_id":this.product_id,
                                               "price":Number(this.price),
                                               "sub_price":Number(this.subPrice),
                                               "qty":Number(this.qty)
                                               });
        },

        updateSubPrice(){          
            this.subPrice = this.price * this.qty;
            this.emitSelected();
        },

        selectedProduct(product_data){
            this.qty = 1;
            this.product_id = product_data.id;
            this.price = product_data.price;
            this.updateSubPrice();
        },

         fetchProduct(){
             axios.get('/api/products/array',this.config)
              .then(({data}) => {
                this.suggestions=data;
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
      }

    }
</script>

<style>

</style>
