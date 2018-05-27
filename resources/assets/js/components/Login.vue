<template>
  <div class="sign-in-body" >
    <div class="text-center" style="margin:auto">
       <form class="form-signin" @submit.prevent="login({ email, password })" >
        <img class="mb-4" src="https://getbootstrap.com/assets/brand/bootstrap-solid.svg" alt="" width="72" height="72">
        <h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
        <label for="inputEmail" class="sr-only">Email address</label>
        <input type="email"v-model="email" id="inputEmail" class="form-control" placeholder="Email address" required autofocus>
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" v-model="password" id="inputPassword" class="form-control" placeholder="Password" required>
        
        <button class="btn btn-lg btn-primary btn-block" type="submit"> <i v-if="isPending"  class="fa fa-login fa-refresh fa-spin"></i>Sign in</button>
        <div v-if="isError" class="alert alert-danger">
          <strong>Danger!</strong> {{messages}}
        </div>
        <p class="mt-5 mb-3 text-muted">created by Ranggaantok@gmail.com</p>
      </form>
    </div>
  </div>
</template>

<script>

export default {
   data() {
    return {
      email: "",
      password: ""
    }
  },

  methods: {
    login() {
      this.$store.dispatch("login", {
        email: this.email,
        password: this.password
      }).then(() => {
        this.$router.push("/")
      });
    },
    
  },

  computed: {
    isPending(){
      return this.$store.getters.isPending;
    },

    isError(){
      return this.$store.getters.isError;
    },

    messages(){
      return this.$store.getters.messages;
    },
  }
  
}
</script>