<template lang="jade">
.navbar
  v-nav()
    .container(v-if="!mobile")
      a.left(href='#', slot='logo') Logo
      ul.right
        li(v-for="page in $store.state.config.pages")
          router-link(:to="page.path" class="nav-item nav-link") 
            | {{ page.name }}
        li(v-for="page in $store.state.config.auth", v-if="$store.state.user.isLoged")
          router-link.nav-item.nav-link(:to="page.path" class="nav-item nav-link")
            | {{ page.name }}
        li(v-if="!$store.state.user.isLoged" @click="openModal") Login / Register
        li(v-if="$store.state.user.isLoged" @click="disconnect") Disconnect
    .container.side-nav-active.center-align(v-else)
      i.material-icons.side-nav-button(v-side-nav:side-nav="nav") menu
      a(href='#', slot='logo') Logo
    v-side-nav#side-nav(slot='side-nav')
      li(@click="closeSideBar",v-for="page in $store.state.config.pages")
        router-link(:to="page.path" class="nav-item nav-link") 
          | {{ page.name }}
      li(@click="closeSideBar", v-for="page in $store.state.config.auth", v-if="$store.state.user.isLoged")
        router-link.nav-item.nav-link(:to="page.path" class="nav-item nav-link")
          | {{ page.name }}
      li(v-if="!$store.state.user.isLoged" @click="openModal") 
        a Login / Register
      li(v-if="$store.state.user.isLoged" @click="disconnect")
        a Disconnect      
</template>

<script lang="coffee">
  Auth = require("../Service/auth")

  module.exports =
    created:->
      @auth = new Auth(this)
    props:
      mobile: type: Boolean
    data: ()->
      {
        nav:
          edge: 'right'
      }
    methods:
      disconnect: ->
        @closeSideBar()
        @auth.logout(@)

      openModal: ->
        @closeSideBar()
        @$emit 'openModal'
      closeSideBar:->
        $('.side-nav-button').sideNav('hide')


</script>

<style lang="scss">

  .side-nav-active {
    position: relative;
    i {
      position: absolute;
    }
  }
  nav {
    background-color: $primary-color;
    img {
      width: 60px;
    }
    ul {
      li {
        padding-left: 5px;
        padding-right: 5px;
        cursor: pointer;
        &:hover {
          background-color: rgba(0, 0, 0, 0.1);
        }
      }
      a {
        &:hover {
          background-color: rgba(0, 0, 0, 0);
        }
      } 
    }
  }
  
</style>
