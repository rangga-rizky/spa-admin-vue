
/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

import VueRouter from 'vue-router';
import router from './routes';
import userStore from  './UserStore';

window.Vue = require('vue');
Vue.use(VueRouter);

/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */

Vue.component('home', require('./components/Home.vue'));
Vue.component('navbar', require('./components/Navbar.vue'));
Vue.component('layout', require('./components/Layout.vue'));
Vue.component('login', require('./components/Login.vue'));
Vue.component('sidebar', require('./components/Sidebar.vue'))
Vue.component('pagination', require('./components/Pagination.vue'));
Vue.component('item-option', require('./components/items/ItemOption.vue'));
Vue.component('detail-form', require('./components/transactions/DetailForm.vue'));
Vue.component('autocomplete', require('./components/AutoComplete.vue'));

axios.defaults.baseURL = 'http://localhost:'+window.location.port+'/';

const app = new Vue({
    el: '#app',
    router,
    store: userStore,
});
