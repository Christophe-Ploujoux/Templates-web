url_to_send = require('../config/template.json').backend
LOGIN_URL = url_to_send + '/auth/login'
REGISTER_URL = url_to_send + '/auth/signup'
FORGET_URL = url_to_send + '/auth/recovery'
USER_URL = url_to_send + '/user?token='
FACEBOOK_LOGIN_URL = url_to_send + '/auth/login/facebook'

module.exports =
  connectUser:(context, token) ->
    context.$http.get(USER_URL + token).then ((res) ->
      localStorage.setItem 'token', token
      user = res.data.user
      user.isLoged = true
      user.token = localStorage.token
      context.$store.commit 'user', user
      context.$dialog 'Vous êtes maintenant connecté', 2500
      context.$emit 'close'
      context.$router.push '/dashboard'
      return
    ), (err) ->
      context.errors = [ err.data.error.message ]
      return
    return

  login: (context, rows) ->
    that = this
    context.$http.post(LOGIN_URL, rows).then ((response) ->
      that.connectUser context, response.data.token
      return
    ), (err) ->
      context.errors = [ err.data.error.message ]
      return
    return
  register: (context, rows) ->
    context.$http.post(REGISTER_URL, rows).then ((response) ->
      context.$dialog 'Votre compte a bien été crée, vous pouvez vous connectez', 2500
      return
    ), (err) ->
      context.errors = [ err.data.error.message ]
      return
    return

  logout: (context) ->
    FB.getLoginStatus (response) ->
      if response.status == 'connected'
        FB.logout()
      return
    context.$router.push '/'
    context.$dialog 'Vous avez bien été deconnecté', 2500
    localStorage.removeItem 'token'
    context.$store.commit 'login', false
    return

  loginFacebook: (context) ->
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
            get_url = undefined
            nom = undefined
            prenom = undefined
            tmp = undefined
            tmp = res.name.split(' ')
            nom = tmp[1]
            prenom = tmp[0]
            get_url = '?email=' + res.email + '&id=' + res.id + '&nom=' + nom + '&prenom=' + prenom
            context.$http.get(FACEBOOK_LOGIN_URL + get_url).then ((res) ->
              context.result = res.data
              return
            ), (err) ->
              context.errors = [ err ]
            return
        ), scope: 'email'
      else
        console.log response
        context.$http.get('test').then ((res) ->
          context.result = res.data
          return
        ), (err) ->
          context.errors = [ err ]
          return
    return

  getUser:(context) ->
    context.$http.get(USER_URL + localStorage.token).then ((res) ->
      user = res.data.user
      user.isLoged = true
      user.token = localStorage.token
      context.$store.commit 'user', user
      return
    ), (err) ->
      context.errors = [ err.data.error.message ]
      return
    return