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
  Auth = require("./Service/auth")
  pages = require("./config/template.json")
  module.exports =
    components:
      Navbar: require './components/Navbar'
      FooterApp: require './components/FooterApp'
      LoginRegister: require './components/LoginRegister'
    computed:
      page:->
        for page in pages.pages
          if @$route.path == page.path
            document.title = @$store.state.config.title + " - " + page.name
            return page
        for page in pages.auth
          if @$route.path == page.path
            document.title = @$store.state.config.title + " - " + page.name
            return page
        return null       
    data: ->
      {
        auth: new Auth(this)
        showModal: false
        isLoged: false
      }
    mounted:->
      @$translate.setLang 'fr'
    created: ->
      mq = window.matchMedia("(max-width: 1000px)")
      @mobile = if mq.matches then true else false
      if (localStorage.token)
        @auth.getUser()
    methods:
      toast:(type, content)->
        if (type == 'error')
          @$dialog content, 2500, 'error-toast'
        if (type == 'success')
          @$dialog content, 2500, 'success-toast'  
               


</script>

<style lang="scss">
  button {
    @media #{$medium-and-down} { 
      font-size: 10px;
      height: auto;
    }
  }
  .content-app {
    padding: 5% 5% 5% 5%;
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
    background-color: $success-color;
  }

  .error-toast {
    background-color: $error-color;
  }

  .fade-enter-active, .fade-leave-active {
    transition: opacity .5s
  }
  .fade-enter, .fade-leave-active {
    opacity: 0
  }
</style>
