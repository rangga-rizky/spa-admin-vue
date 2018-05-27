import Vuex from 'vuex';
import Vue from 'vue';

Vue.use(Vuex);

const LOGIN = "LOGIN";
const LOGIN_SUCCESS = "LOGIN_SUCCESS";
const LOGOUT = "LOGOUT";
const LOGIN_FAILED = "LOGIN_FAILED";
const SHOW_SUCCESS = "SHOW_SUCCESS";


const userStore = new Vuex.Store({

  state: {
    isLoggedIn: !!localStorage.getItem("token"),
    isPending: false,
    isError : false,
    messages : "",
    isSuccess : false,
  },

  mutations: {
    [LOGIN] (state) {
      state.isPending = true;
    },
    [LOGIN_SUCCESS] (state) {
      state.isLoggedIn = true;
      state.isPending = false;
    },
    [LOGIN_FAILED] (state,message) {
      state.isPending = false;
      state.isError = true;
      state.messages = message;
    },
    [LOGOUT](state) {
      state.isLoggedIn = false;
    },
     [SHOW_SUCCESS](state,message) {
      state.isSuccess = true;
      state.messages = message;
    },
  },

  actions: {
	   login({ commit }, creds) {
	     commit(LOGIN);
       var config = {
        headers: {'Content-Type': 'application/json' }
       };
	     return new Promise(resolve => {
	       axios.post('/api/login', {
          email: creds.email,
          password: creds.password
        },config)
        .then(function (response) {              
          localStorage.setItem("token", response.data.data.token);
          commit(LOGIN_SUCCESS);          
          resolve();
        })
        .catch(function (error) {    
          var errorMsg = "";      
          if(error.response.status == 401){
            errorMsg = error.response.data.error;
          }else{
            errorMsg = "Terjadi Kesalahan pada server.";
          }
          commit(LOGIN_FAILED,errorMsg);
          resolve();
        });
	     });
	   },
	   logout({ commit }) {
	     localStorage.removeItem("token");
	     commit(LOGOUT);
	   },

     success({ commit },message) {
       commit(SHOW_SUCCESS,message);
     },
   },

   getters: {
   	isLoggedIn(state) {  	  
    	return state.isLoggedIn;
	   },
     isPending(state) {      
      return state.isPending;
     },

    isError(state) {      
      return state.isError;
     } ,   

    isSuccess(state) {      
      return state.isSuccess;
     } ,     

     messages(state){
      return state.messages;
    },
   },

});

export default userStore;