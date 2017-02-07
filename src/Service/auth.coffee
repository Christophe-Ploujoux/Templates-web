url_to_send = require('../config/template.json').backend
LOGIN_URL = url_to_send + '/auth/login'
REGISTER_URL = url_to_send + '/auth/signup'
FORGET_URL = url_to_send + '/auth/recovery'
USER_URL = url_to_send + '/user?token='
FACEBOOK_LOGIN_URL = url_to_send + '/auth/login/facebook'

class Auth
  constructor: (@context)->
    @root = @context.$parent

  connectUser:(token) ->
    that = this
    @context.$http.get(USER_URL + token).then ((res) ->
      localStorage.setItem 'token', token
      user = res.data.user
      user.isLoged = true
      user.token = localStorage.token
      that.context.$store.commit 'user', user
      that.root.toast 'success', 'Vous êtes maintenant connecté'
      that.context.$emit 'close'
      that.context.$router.push '/dashboard'
      return
    ), (err) ->
      that.context.errors = [ err.data.error.message ]
      return
    return

  login: (rows) ->
    that = this
    @context.$http.post(LOGIN_URL, rows).then ((response) ->
      that.connectUser response.data.token
      return
    ), (err) ->
      console.log that.context
      that.context.errors = [ err.data.error.message ]
      return
    return

  register: (rows) ->
    that = this
    @context.$http.post(REGISTER_URL, rows).then ((response) ->
      that.root.toast 'success', 'Votre compte a bien été crée, vous pouvez vous connectez'
      return
    ), (err) ->
      that.context.errors = [ err.data.error.message ]
      return
    return

  logout: () ->
    FB.getLoginStatus (response) ->
      if response.status == 'connected'
        FB.logout()
      return
    @context.$router.push '/'
    @root.toast 'success', 'Vous avez bien été deconnecté'
    localStorage.removeItem 'token'
    @context.$store.commit 'login', false
    return

  loginFacebook: () ->
    that = this
    FB.getLoginStatus (response) ->
      if response.status != 'connected'
        FB.login ((response) ->
          FB.api '/me', {
            locale: 'en_US'
            fields: 'name, email'
          }, (res) ->
            console.log response
            console.log res
            console.log that
            tmp = res.name.split(' ')
            nom = tmp[1]
            prenom = tmp[0]
            get_url = '?email=' + res.email + '&id=' + res.id + '&nom=' + nom + '&prenom=' + prenom
            that.context.$http.get(FACEBOOK_LOGIN_URL + get_url).then ((res) ->
              that.context.result = res.data
              return
            ), (err) ->
              that.context.errors = [ err ]
            return
        ), scope: 'email'
      else
        console.log response
        that.context.$http.get('test').then ((res) ->
          that.context.result = res.data
          return
        ), (err) ->
          that.context.errors = [ err ]
          return
    return

  getUser:() ->
    that = this
    @context.$http.get(USER_URL + localStorage.token).then ((res) ->
      user = res.data.user
      user.isLoged = true
      user.token = localStorage.token
      that.context.$store.commit 'user', user
      return
    ), (err) ->
      that.context.errors = [ err.data.error.message ]
      return
    return

module.exports = Auth
