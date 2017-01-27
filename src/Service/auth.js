const url_to_send = "http://localhost:8000/api"
const LOGIN_URL = url_to_send + "/auth/login"
const REGISTER_URL = url_to_send + "/auth/signup"
const FORGET_URL = url_to_send + "/auth/recovery"
const USER_URL = url_to_send + "/user?token="
const FACEBOOK_LOGIN_URL = url_to_send + '/auth/login/facebook'

export default {
  authentication: class Authentication {
    static connectUser(context, token) {
      context.$http.get(USER_URL + token).then((res) => {
        localStorage.setItem("token", token)
        var user = res.data.user
        user.isLoged = true
        user.token = localStorage.token
        context.$store.commit("user", user) 
        context.$dialog('Vous êtes maintenant connecté', 2500);
        context.$emit('close')
        document.location = "/#/dashboard"
      },
      (err) => {
        context.errors = [err.data.error.message]
      });
    }
    static login(context, rows) {
      var that = this
      context.$http.post(LOGIN_URL, rows)
      .then((response) => {
        that.connectUser(context, response.data.token)
      }, (err) => {
        context.errors = [err.data.error.message]
      });
    }

    static register(context, rows) {
      context.$http.post(REGISTER_URL, rows)
      .then((response) => {
        context.$dialog('Votre compte a bien été crée, vous pouvez vous connectez', 2500);
      }, (err) => {
        context.errors = [err.data.error.message]
      })
    }

    static logout(context) {
      FB.getLoginStatus((response) => {
        if (response.status == 'connected')
          FB.logout()
      })
      window.location = '#/'
      context.$dialog('Vous avez bien été deconnecté', 2500)
      localStorage.removeItem("token")
      context.$store.commit("login", false)
    }

    static loginFacebook(context) {
      var that = this;
      FB.getLoginStatus(function(response) {
        if (response.status !== 'connected') {
          return FB.login((function(response) {
            return FB.api('/me', {
              locale: 'en_US',
              fields: 'name, email'
            }, function(res) {
              console.log(response)
              console.log(res)
              var get_url, nom, prenom, tmp;
              tmp = res.name.split(' ');
              nom = tmp[1];
              prenom = tmp[0];
              get_url = '?email=' + res.email + '&id=' + res.id + '&nom=' + nom + '&prenom=' + prenom;
              context.$http.get(FACEBOOK_LOGIN_URL + get_url).then(function(res) {
                context.result = res.data;
              }, function(err) {
                return context.errors = [err];
              });
            });
          }), {
            scope: 'email'
          });
        } 
        else {
          console.log(response)
          return context.$http.get('test').then(function(res) {
            context.result = res.data;
          }, function(err) {
            context.errors = [err];
          });
        }
      });      
    }
    static getUser(context) {
      context.$http.get(USER_URL + localStorage.token)
      .then ((res) => {
        var user = res.data.user
        user.isLoged = true
        user.token = localStorage.token
        context.$store.commit("user", user)    
      }  
      , (err) => {
        context.errors = [err.data.error.message]
      })    
    }
  }
}