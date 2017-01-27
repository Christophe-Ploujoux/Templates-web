<template lang="jade">
  .dashboard
    h1 Dashboard
</template>

<script lang="coffee">
  module.exports =
    mounted: ->
      console.log @$store.state.user
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss" scoped>

</style>
