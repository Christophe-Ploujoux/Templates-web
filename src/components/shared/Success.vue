<!-- 
Composant Success vue:
  message: String('message')
  close: Boolean(afficher)
 -->

<template lang="jade">
  .success
    transition(name="fade")
      .card-panel.green(v-if="close")
        i.white-text.close.material-icons.right(@click="send") close
        span.white-text(v-translate) {{ message }}
</template>

<script lang="coffee">
  module.exports =
    props:
      message: type: String
      close: type: Boolean
    methods: 
      send: ->
        @$emit 'send'
        return
</script>

<style lang="scss">
.success {
  .card-panel {
    margin: 2.5rem 0 1rem 0;
  }
  .close {
    cursor: pointer;
  }
  .fade-enter-active, .fade-leave-active {
    transition: opacity .5s
  }
  .fade-enter, .fade-leave-active {
    opacity: 0
  }
}
</style>