<template lang="jade">
  .gallery-item
    img(:src="'/static/img/' + item.img")
</template>

<script lang="coffee">
  module.exports =
    props:
      item:
        type: Object
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss">
  .gallery-item {
    img {
      width: 100%;
      height: 280px;
    }
  }
</style>
