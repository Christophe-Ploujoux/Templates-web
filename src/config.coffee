Vue = require 'vue'
VueResource = require 'vue-resource'
VueTranslate = require 'vue-translate-plugin'
Materials = require "vue-materials"

Vue.use VueResource
Vue.use VueTranslate
Vue.use Materials.default


((d, s, id) ->
  js = undefined
  fjs = d.getElementsByTagName(s)[0]
  if d.getElementById(id)
    return
  js = d.createElement(s)
  js.id = id
  js.src = 'https://connect.facebook.net/en_US/sdk.js#version=v2.2&appId=360554577631913&status=true&cookie=true&xfbml=true'
  fjs.parentNode.insertBefore js, fjs
  return
) document, 'script', 'facebook-jssdk'

store = require './store'
router = require './router'
App = require './App'
new Vue(
  created: ->
    template = require('./config/template.json')
    @$store.commit 'config', template
    document.title = template.title
    $('meta[name="description"]').attr 'content', template.description
    $('#favicon32').attr 'href', template.frontend + '/static/img/' + template.favicon32
    $('#favicon180').attr 'href', template.frontend + '/static/img/' + template.favicon180
    $('#favicon192').attr 'href', template.frontend + '/static/img/' + template.favicon192
    return
  router: router
  store: store
  el: '#app'
  locales: require("./config/i18n.json")
  render: (h)-> h(App)
)