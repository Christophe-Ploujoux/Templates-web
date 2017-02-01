<template lang="jade">
.parallax-component
   v-parallax(:src="getSrc(template.img)", :height="template.height")
</template>

<script lang="coffee">
  module.exports =
    props:
      template: type : Object
    methods:
      getSrc: (src)->
        if src.indexOf("http://") != -1
          return src
        return "/static/images/" + src
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss">
@import "../assets/style/variable.scss";

</style>
