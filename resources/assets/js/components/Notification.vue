<template>
    <span @click="readNotif" >
       <router-link  class="dropdown-item" :to="{ name: link }">
           <p><i class="fa fa-envelope mr-2"></i> {{msg}}</p>
       </router-link>   
    <div class="dropdown-divider"></div>   
    </span>    
</template>

<script>

export default {
    props: {
      msg: {
          type: String,
          required: true
      },
       link: {
          type: String,
      },
      id:{
          type:String
      }
    },

    methods: {
        readNotif() {
            axios.post('/api/notifications/read/'+this.id,{},{
        			headers: {
        				'Content-Type': 'application/json' ,
        				'Authorization' : 'Bearer '+ localStorage.getItem("token"),
        			},
       			})
			        .then(({data}) => {
			        	 this.$store.dispatch('getNotification').then(() => {
                        });
				      })
			        .catch((error) => {	     
					   
		        });  
        },
    },
        
}
</script>