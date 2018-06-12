<template>
       <!-- Notifications Dropdown Menu -->
      <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#">
          <i class="fa fa-bell-o"></i>
          <span v-if="!isNotifEmpty" class="badge badge-danger navbar-badge">!</span>
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
          <notification  v-for="(notif, index) in getNotifications"  v-bind:key="index" :msg="notif.user_name+' Membuat Item baru'" link="item" :id="notif.id" />          
          <a href="#" class="dropdown-item dropdown-footer">See All Notifications</a>
        </div>
      </li>

</template>

<script>

export default { 
    created(){
      this.fetchNotif();
    },

    methods: {
      fetchNotif() {
        this.$store.dispatch('getNotification').then(() => {
        });
      }
    },
    
    computed: {
      getNotifications() {
        return  this.$store.getters.getNotifications;
     },

     isNotifEmpty(){
       return  this.$store.getters.getNotifications.length ===0;
     }
    }      
}
</script>