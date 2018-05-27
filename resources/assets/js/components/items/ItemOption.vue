<template>
    <div class="row">
       <div class="col-5">
          <div class="form-group">
            <label for="item">Item : </label>
            <select class="form-control" id="item" v-model="selectedItem" @change="selected()">
              <option v-for="item in items" v-bind:value="item.id" >
                {{ item.name }}
            </option>
        </select>
        </div>
        </div> 
        <div class="col-2">
          <div class="form-group">
            <label for="qty">Qty :</label>
            <input type="number" v-model="qty" class="form-control" id="qty" @change="selected()" placeholder="Masukan Jumlah Stok" required="">
        </div>
        </div> 
        <div class="col-2">
          <button style="margin-top: 30px" type="button" class="btn btn-danger"  @click="$emit('delete-row')">
            <i class="fa fa-minus"></i>
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

         data() {
            return {
              items : [],
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
          this.fetchItem();
        },


        methods:{   

          fetchItem(){
             axios.get('/api/items/array',this.config)
              .then(({data}) => {
                this.items=data;
                this.selectedItem = data[0].id;
                this.selected();
                //console.log(data);
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

          selected(){
            this.$emit('selected',this.index, {"item_id":this.selectedItem,"qty":Number(this.qty)});
          }
      }            

    }
</script>
