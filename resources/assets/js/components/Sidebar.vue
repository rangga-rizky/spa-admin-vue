<template>
      <!-- Main Sidebar Container -->
    <aside class="main-sidebar sidebar-dark-primary elevation-4">
      <!-- Brand Logo -->
    <a href="index3.html" class="brand-link">
      <img src="admin-lte/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3"
           style="opacity: .8">
      <span class="brand-text font-weight-light">Admin</span>
    </a>
    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="admin-lte/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a href="#" class="d-block">{{name}}</a>
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
              <li class="nav-item">
                <router-link  :to="{ name: 'dashboard'}"  class="nav-link">                  
                    <i class="nav-icon fa fa-bar-chart-o"  :class="{ 'text-info': isActive('dashboard') }"></i>
                    <p>Dashboard</p>
                </router-link>
              </li>
              <li class="nav-item">
                <router-link  :to="{ name: 'item'}"  class="nav-link" >
                  <i class="nav-icon  fa fa-file-o"   :class="{ 'text-info': isActive('item') }"></i>
                  <p>Items</p>
                </router-link>
              </li>

              <li class="nav-item">
                <router-link  :to="{ name: 'product'}"  class="nav-link">
                  <i class="nav-icon fa fa-table"  :class="{ 'text-info': isActive('product') }"></i>
                  <p>Products</p>
                </router-link>
              </li>

               <li class="nav-item">
                <router-link  :to="{ name: 'item-product'}"  class="nav-link">
                  <i class="nav-icon fa fa-archive"  :class="{ 'text-info': isActive('item-product') }"></i>
                  <p>Item of Product</p>
                </router-link>
              </li>

               <li class="nav-item">
                <router-link  :to="{ name: 'transaction'}"  class="nav-link">
                  <i class="nav-icon fa fa-handshake-o"  :class="{ 'text-info': isActive('transaction') }"></i>
                  <p>Transaction</p>
                </router-link>
              </li>
        </ul>
      </nav>
          <!-- /.sidebar-menu -->
        </div>
        <!-- /.sidebar -->
    </aside>
</template>

<script>
    export default {
        data(){
          return {
            name:"",
            config: {
                headers: {
                  'Content-Type': 'application/json' ,
                  'Authorization' : 'Bearer '+ localStorage.getItem("token"),
                },
            },
          }
        },

        created(){
          this.fetch();
        },
        
        methods: {
          isActive(menuItem) {
            return this.$route.name === menuItem;
          },

          fetch() {
		    	axios.get('/api/users/current',this.config)
			        .then(({data}) => {
			        	//console.log(data);
				        this.name = data.name;
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
        },
        
    }
</script>
