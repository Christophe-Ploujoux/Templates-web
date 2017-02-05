Vue = require 'vue'
Vuex = require 'vuex'

Vue.use(Vuex)
module.exports =
  new Vuex.Store(
    state:
      user:
        name: ''
        email: ''
        isLoged: false
        token: ''
      config: {}
    mutations:
      login: (state, status) ->
        state.user.isLoged = status
        return
      user: (state, user) ->
        state.user = user
        return
      config: (state, config) ->
        state.config = config
        return
  )