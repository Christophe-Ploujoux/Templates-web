import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)
// ===================== Pages Components ======================
import Home from './Home'
import Dashboard from './Dashboard'


// ==================== Router registration ====================
export default new Router({
  mode: 'hash',
  routes: [
    { path: '/', component: Home },
    // { path: '/dashboard', component: Dashboard, redirect: to => {
    // 	if (1+1 == 2)
    // 		return '/'
    // 	return '/dashboard'
    // }}
    {path: '/dashboard', component: Dashboard}
  ]
})
