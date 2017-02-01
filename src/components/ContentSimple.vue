<template lang="jade">
div(v-html="template.content")
</template>
<script lang="coffee">
  module.exports =
    props:
      template: type : Object
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss">
@import "../assets/style/variable.scss";

</style>
