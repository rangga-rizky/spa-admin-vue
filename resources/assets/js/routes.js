import VueRouter from 'vue-router';
import Item from './components/Item.vue';
import ItemCreate from './components/items/Create.vue';
import ItemEdit from './components/items/Edit.vue';
import Dashboard from './components/Dashboard.vue';
import Home from './components/Home.vue';
import Product from './components/Product.vue';
import ProductCreate from './components/products/Create.vue';
import ProductEdit from './components/products/Edit.vue';
import Transaction from './components/Transaction.vue';
import TransactionEdit from './components/transactions/Edit.vue';
import TransactionCreate from './components/transactions/Create.vue';
import TransactionDetail from './components/TransactionDetail.vue';
import ItemProduct from './components/ItemProduct.vue';
import ItemProductEdit from './components/item-products/Edit.vue';
import ItemProductCreate from './components/item-products/Create.vue';
import Login from './components/Login.vue';
import userStore from './UserStore' 


let routes = [  
    {
        path: '/',
        component: Home,
        meta: { requiresAuth: true} ,
        children: [
          {
            path: '/',
            component: Dashboard,
            name: 'dashboard', 
            meta: { requiresAuth: true} ,
          },
          {
            path: 'items',
            component: Item,
            name: 'item', 
            meta: { requiresAuth: true} ,
          },
          {
            path: 'items/create',
            component: ItemCreate,
            name: 'item-create', 
            meta: { requiresAuth: true} ,
          },
           {
            path: 'items/:id',
            component: ItemEdit,
            name: 'item-edit', 
            meta: { requiresAuth: true} ,
            props: true,
          },
           {
            path: 'products',
            component: Product,
            name: 'product', 
            meta: { requiresAuth: true} ,
          },
          {
            path: 'products/create',
            component: ProductCreate,
            name: 'product-create', 
            meta: { requiresAuth: true} ,
          },
           {
            path: 'products/:id',
            component: ProductEdit,
            name: 'product-edit', 
            meta: { requiresAuth: true} ,
            props: true,
          },
           {
            path: 'item-products',
            component: ItemProduct,
            name: 'item-product', 
            meta: { requiresAuth: true} ,
          },
          
          {
            path: 'item-products/create',
            component: ItemProductCreate,
            name: 'item-product-create', 
            meta: { requiresAuth: true} ,
            props: true,
          },
           {
            path: 'item-products/:id',
            component: ItemProductEdit,
            name: 'item-product-edit', 
            meta: { requiresAuth: true} ,
            props: true,
          },
           {
            path: 'transactions',
            component: Transaction,
            name: 'transaction', 
            meta: { requiresAuth: true} ,
          },
          {
            path: 'transactions/create',
            component: TransactionCreate,
            name: 'transaction-create', 
            meta: { requiresAuth: true} 
          },
           {
            path: 'transactions/:id/detail',
            component: TransactionDetail,
            name: 'transaction-details', 
            meta: { requiresAuth: true} ,
             props: true,
          },
            {
            path: 'transactions/:id',
            component: TransactionEdit,
            name: 'transaction-edit', 
            meta: { requiresAuth: true} ,
             props: true,
          },
        ],
    },
    {
        path: '/login',
        component: Login,
        meta: { requiresAuth: false} ,
    },


];

const router = new VueRouter({
    routes
});

router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    if (!userStore.getters.isLoggedIn) {
      next({
        path: '/login',
      });
    } else {
      next();
    }
  } else {
    if (userStore.getters.isLoggedIn) {
       next({
        path: '/',
      });
    }else{
     next();   
    }
  }
})

export default router;