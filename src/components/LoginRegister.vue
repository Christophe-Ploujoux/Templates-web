<template lang="jade">
modal.login(@close="$emit('close')")
  .login-button(slot="header")
    button.waves-effect.waves-light.btn(@click="changeShowLogin" v-bind:class="{ active : showLogin }" type="button") Se connecter
    button.waves-effect.waves-light.btn(@click="changeShowRegister" v-bind:class="{ active : !showLogin }" type="button") S'inscrire
  .modal-content(slot="body")
    .container.pop-alert
      alert(:errors="errors", @send="initialize")              
      success(v-if="success.length > 0", :message="success",@send="initialize", :close="successClose")
    div(v-if="showLogin")
      div(v-if="!showForget")
        .social-login.center-align
          button.btn.blue.darken-4(@click="sendLoginFacebook", type="button")
            span Connexion avec
            i.fa.fa-facebook
        form-vue(:clean="false", :inputs="login", :name="formLoginName", @send="sendLogin", :center="true")
          a.col.s12.forget-link(href="#", @click="changeShowForget") J'ai oublié mon mot de passe
      form-vue(v-if="showForget", :clean="true", :inputs="forget", :name="formForgetName", @send="sendForget", :center="true")
    form-vue(v-if="!showLogin", :clean="false", :inputs="register", :name="formRegisterName", @send="sendRegister", :center="true")
</template>

<script lang="coffee">
  formVue = require './formVue'
  Alert = require './Alert'
  Success = require './Success'
  validator = require('validator')
  Modal = require("./Modal")
  Auth = require("../Service/auth")

  module.exports =
    created:->
      @auth = new Auth(this)
    components:
      formVue: formVue
      Alert: Alert
      Success: Success
      Modal: Modal
    data: ->
      {
        valid: validator
        login: [
          {name: 'email', type: 'email', style: 's12', valid: validator.isEmail, required: true }
          {name: 'password', type: 'password', style: 's12', required: true }
        ]
        register: [
          {name: 'register_email', label: 'Email', type: 'email', style: 's12', valid: validator.isEmail, required: true}
          {name: 'name', type: 'text', style: 's12', required: true }
          {name: 'password', type: 'password', style: 's12', required: true }
          {name: 'password_confirmation', label: 'Confirmation du mot de passe', type: 'password', style: 's12', required: true }
        ]
        forget: [
          {name: 'forget-email', label: 'Email', type: 'email', style: 's12', valid: validator.isEmail, required: true } ]
        showLogin: true
        showForget: false
        success: ''
        successClose: true
        errors: []
        formRegisterName: 'S\'inscrire'
        formForgetName: 'Envoyer l\'email'
        formLoginName: 'Se connecter'
      }    
    methods:
      sendLogin: (rows) ->
        @auth.login(rows)
      sendLoginFacebook: ->
        @auth.loginFacebook()
      sendRegister: (rows) ->
        @auth.register(rows)
      sendForget: (rows) ->
        @auth.sendForget(rows)
      initialize: ->
        @errors = []
        @success = ''
        @successClose = true
        return
      changeShowRegister: ->
        if @showLogin
          @showLogin = !@showLogin
        @showForget = false
      changeShowLogin: ->
        if !@showLogin
          @showLogin = !@showLogin
        @showForget = false

      changeShowForget: ->
        FB.getLoginStatus (response) ->
          if (response.status == 'connected')
            FB.logout()        
        @showForget = !@showForget
        
</script>

<style lang="scss">

  .login {
    width: 100%;
    padding: 50px;
    padding: 0;
    button {
      background-color: $secondary-color;
    }
    .social-login {
      width: 100%;
      margin-top: 20px;
    }
    .inline {
      display: inline;
    }
    .row {
      margin-top: 20px;
    }    
    .modal-content {
      margin: 0 0 0 0;
      padding-bottom: 4%;
      padding-top: 4%;
    }
    .login-button {
      button {
        border-radius: 0px;
        width: 50%;
        display: block;
        float: left;
        margin: 0 0 3% 0;
        padding: 0;
        @media #{$large-and-up} {
          height: 60px;
        }       
      }
    }
    .forget-link {
      margin-top: 2%;
    }
  }
</style>
