<template lang="jade">
  div(class="app")
    navbar(:mobile="mobile", @openModal="showModal = true")
    .center-align
      transition(name="fade", mode="out-in")
        router-view(v-if="page", :title="page.name" ,:contents="page.contents")
        router-view(v-else)
    login-register(v-if="showModal && !isLoged", @close="showModal = false")
    footer-app
</template>

<script lang="coffee">
  Navbar = require './components/Navbar'
  FooterApp = require './components/FooterApp'
  loginRegister = require './components/LoginRegister'
  auth = require("./Service/auth")
  pages = require("./config/template.json").pages
  module.exports =
    components:
      Navbar: Navbar
      FooterApp: FooterApp
      LoginRegister: loginRegister
    computed:
      page:->
        for page in pages
          if @$route.path == page.path
            document.title = @$store.state.config.title + " - " + page.name
            return page
        return null       
    data: ->
      {
        showModal: false
        isLoged: false
      }
    created: ->
      mq = window.matchMedia("(max-width: 1000px)")
      @mobile = if mq.matches then true else false
      if (localStorage.token)
        auth.getUser(@)


</script>

<style lang="scss">
  @import "./assets/style/variable.scss";
  // Bootstrap

  // font awesome

  button {
    @media #{$medium-and-down} { 
      font-size: 10px;
      height: auto;
    }
  }
  .content-app {
    padding: 5% 5% 5% 5%;
  }
  .toast {
    background-color: #4caf50;
  }

  input:not([type]), input[type=text], input[type=password], 
  input[type=email], input[type=url], 
  input[type=time], input[type=date], 
  input[type=datetime], input[type=datetime-local], 
  input[type=tel], input[type=number], 
  input[type=search], textarea.materialize-textarea, .select-wrapper input.select-dropdown {
    border-bottom: 1px solid #ccd0d2;
  }

  ::-webkit-input-placeholder { /* WebKit, Blink, Edge */
    opacity: 0;
  }
  :-moz-placeholder { /* Mozilla Firefox 4 to 18 */
     opacity:  0;
  }
  ::-moz-placeholder { /* Mozilla Firefox 19+ */
     opacity:  0;
  }
  :-ms-input-placeholder { /* Internet Explorer 10-11 */
     opacity:  0;
  }

  .success-toast {
    background-color: #4caf50;
  }

  .error-toast {
  background-color: #e53935;
  }

  .fade-enter-active, .fade-leave-active {
    transition: opacity .5s
  }
  .fade-enter, .fade-leave-active {
    opacity: 0
  }
</style>
