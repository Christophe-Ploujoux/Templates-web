Vue = require 'vue'
Router = require 'vue-router'

Vue.use(Router)

# ===================== Pages Components ======================
Dashboard = require './Dashboard'
Page = require './Page'

pages = require('./config/template.json').pages

Routes = []
for page in pages
  Routes.push({
    path: page.path,
    component: Page
  })

Routes.push
  path: '/dashboard'
  component: Dashboard
  beforeEnter: (route, redirect, next) ->
    if route.path.indexOf('/dashboard') != -1
      if !localStorage.token
        return next('/')
      return next()
    return

module.exports =
  new Router({
    mode: 'hash',
    routes: Routes
  })