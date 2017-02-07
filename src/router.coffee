Vue = require 'vue'
Router = require 'vue-router'

Vue.use(Router)

pages = require('./config/template.json').pages
auth_pages = require('./config/template.json').auth

Routes = []
for page in pages
  toPush =
    path: page.path
    component: if page.component then require("./" + page.component) else require './Page'
  Routes.push
    path: page.path
    component: if page.component then require("./" + page.component) else require './Page'

for page in auth_pages
  Routes.push
    path: page.path
    component: if page.component then require("./" + page.component) else require './Page'
    beforeEnter: (route, redirect, next) ->
      if !localStorage.token
        return next('/')
      return next()

module.exports =
  new Router({
    mode: 'hash',
    routes: Routes
  })