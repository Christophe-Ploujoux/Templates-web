<template lang="jade">
.navbar
  v-nav()
    .container(v-if="!mobile")
      a.left(href='#', slot='logo') Logo
      ul.right
        li(v-for="page in $store.state.config.pages")
          router-link(:to="page.path" class="nav-item nav-link") {{ page.name }}
        li
          router-link.nav-item.nav-link(v-if="$store.state.user.isLoged" to="/dashboard" class="nav-item nav-link") Dashboard
        li(v-if="!$store.state.user.isLoged" @click="openModal") Login / Register
        li(v-if="$store.state.user.isLoged" @click="disconnect") Disconnect
    .container.side-nav-active.center-align(v-else)
      i.material-icons(v-side-nav:side-nav="nav") menu
      a(href='#', slot='logo') Logo
    v-side-nav#side-nav(slot='side-nav')
      li
        router-link(to="/" class="nav-item nav-link") Home
      li
        router-link.nav-item.nav-link(v-if="$store.state.user.isLoged" to="/dashboard" class="nav-item nav-link") Dashboard
      li(v-if="!$store.state.user.isLoged" @click="openModal") 
        a Login / Register
      li(v-if="$store.state.user.isLoged" @click="disconnect")
        a Disconnect      
</template>

<script lang="coffee">
  auth = require("../Service/auth")

  module.exports =
    props:
      mobile: type: Boolean
    data: ()->
      {
        nav:
          edge: 'right'
      }
    methods:
      disconnect: ->
        auth.logout(@)

      openModal: ->
        @$emit 'openModal'

</script>

<style lang="scss">
  @import "../assets/style/variable.scss";

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
