<template lang="jade">
.slider-component
  v-slider(:indicators="template.indicators", :height="height", :transition="template.transition")
    v-slide(:src='getSrc(slide.img)' v-for="slide in template.slides")
      .container.slide-content(v-if="slide.content")
        h1(v-if="template.slides.indexOf(slide) == 0") {{ slide.content.title }}
        h2(v-else) {{ slide.content.title }}
        p {{ slide.content.subtitle }}
</template>

<script lang="coffee">
  module.exports =
    props:
      template: type : Object
    data:->
      {
        height: 800
      }
    mounted:->
      @height = $(".slider-component").height()
    methods:
      getSrc: (src)->
        if src.indexOf("http://") != -1
          return src
        return "/static/images/" + src
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss">
@import "../assets/style/variable.scss";

.slider-component {
  position: relative;
  height: 700px;
  @media #{$medium-and-down} { 
    height: 550px;
  }
  .slide-content {
    margin-top: 20%;
    h2 {
      font-size: 4.2rem;
    }
    p {
      font-size: 3.2rem;
      color: #fff !important;
    }
  }
}
.slider {
  .indicators {
    bottom: 8%;
    z-index: 9999;
  }
}
</style>
