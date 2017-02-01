<template lang="jade">
.home
  .contents(v-for="content in contents")
    component(:is="content.name", :template="content.template")
</template>

<script lang="coffee">
  Slider = require "./components/Slider"
  Parallax = require "./components/Parallax"
  ContentSimple = require "./components/ContentSimple"

  module.exports =
    locales: require('./i18n/Hello.js')
    components:
      slider: Slider
      parallax: Parallax
      contentSimple: ContentSimple
    data:->
      {
        contents: @$store.state.config.home
      }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss" scoped>
@import "./assets/style/variable.scss";

.home {
  .uppage {
    height: 700px;
    @media #{$medium-and-down} { 
      height: 550px;
    }
  }
}

</style>
