<template lang="jade">
  v-footer
    .container(slot='content')
      .row
        .col.l6.s12
          h5.white-text Footer Content
          p.grey-text.text-lighten-4 You can use rows and columns here to organize your footer content.
        .col.l4.offset-l2.s12
          h5.white-text Links
          ul
            li
              a.grey-text.text-lighten-3(href='#!') Link 1
            li
              a.grey-text.text-lighten-3(href='#!') Link 2
            li
              a.grey-text.text-lighten-3(href='#!') Link 3
            li
              a.grey-text.text-lighten-3(href='#!') Link 4
    .container(slot='copyright') © Copyright 2016
</template>

<script lang="coffee">

</script>

<style lang="scss">
  @import "../assets/style/variable.scss";

  .page-footer {
    background-color: $primary-color !important;
  }

</style>
