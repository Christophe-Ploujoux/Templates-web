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
    props:
      contents:
        type: Array
      title:
        type: String
    components:
      slider: Slider
      parallax: Parallax
      contentSimple: ContentSimple
</script>
