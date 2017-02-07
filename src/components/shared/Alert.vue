<!--
Composant Alert vue:
  errors: Array['message']

 -->
<template lang="jade">
  .alert
    transition(name="fade")
      .card-panel.red.alert-vue(v-if="errors.length > 0")
        i.white-text.close.material-icons.right(@click="send") close
        span.white-text(v-translate, v-for="error in errors") {{ error }}
          br
</template>

<script lang="coffee">
  module.exports = 
    props: errors: type: Array
    data: ->
      { show: false }
    methods: 
      send: ->
        @$emit 'send'
        return
</script>

<style lang="scss">
.alert {
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
