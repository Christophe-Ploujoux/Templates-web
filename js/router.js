import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)
// ===================== Pages Components ======================
import Home from './Home'
import Dashboard from './Dashboard'
import Page from './Page'

let pages = require('./config/template.json').pages
let Routes = []
for (var page of pages) {
  Routes.push({
    path: page.path,
    component: Page
  })
}
Routes.push(
  {
    path: '/dashboard',
    component: Dashboard,
    beforeEnter (route, redirect, next) {
      if (route.path.indexOf("/dashboard") !== -1) {
       if (!localStorage.token) {
          return next('/') 
       }
       return next()
      }
    }
  }
)

// ==================== Router registration ====================
export default new Router({
  mode: 'hash',
  routes: Routes
})
