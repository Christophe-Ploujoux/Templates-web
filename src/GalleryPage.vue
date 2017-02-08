<template lang="jade">
.gallery
  h1 Gallery
  gallery(:items="items")
</template>

<script lang="coffee">
  product = require('./config/product.json')

  module.exports =
    components:
      Gallery: require('./components/Gallery')
    data:->
      {
        items: product.items
      }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss">

</style>
