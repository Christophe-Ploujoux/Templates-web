<template lang="jade">
.home
  .uppage
    v-slider(:indicators="false", :height="height")
      v-slide(src='/static/images/yaplusk.jpg')
        .container.first-slide
          h1 v-slide 1
      v-slide(src='/static/images/esports.jpg')
        h3 v-slide 2
  .content
    h3 Test
   v-parallax(src="http://materializecss.com/images/parallax1.jpg", :height="250")
  .test
    h3 test
</template>

<script lang="coffee">
  # console.log $(".slider")
  module.exports =
    locales: require('../i18n/Hello.js')
    data:->
      {
        height: 800
      }
    mounted:->
      @height = $(".uppage").height()
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss" scoped>
@import "../assets/style/variable.scss";

.home {
  .uppage {
    height: 700px;
    @media #{$medium-and-down} { 
      height: 550px;
    }
  }
}

</style>
