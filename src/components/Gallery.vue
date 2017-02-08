<template lang="jade">
.gallery
  .input-model.center-align
    ul.items
      li(v-for="category in categories", :class="{ active: category.active }" @click="changeModel(category)") {{ category.name }}
  .gallery-items.row
    .col.m4.item(v-for="(item, index) in items", :style="item.style", :class="['index-' + index]")
      item(:item="item")
</template>

<script lang="coffee">
  module.exports =
    components:
      Item: require('./GalleryItem')
    props:
      items:
        type: Array
    data:->
      {
        categories: [],
        vModel: "All"
      }
    methods:
      changeModel:(category)->
        for cat in @categories
          cat.active = false
        category.active = true
        @vModel = category.name
        @changePositionItems()
      changePositionItems:->
        x = 0
        y = 0
        i = 1
        for item, index in @items      
          item.style =
            "transition-property": "opacity, transform"
            "transition-duration": "0.6s"
          if @vModel == "All" || @vModel == item.category
            item.style["transform"] = "translate3d(" + (x-1) + "px," + y + "px, 0px)"
            x += $('.item').width()
            if i > 2
              x = 0
              y += $('.item').height() - 6
              i = 0
            i++
          else
            item.style["transform"] = "scale(0.001)"

    mounted:->
      @categories.push
        name: "All"
        active: true
      $('.gallery-items').css("height", Math.ceil(@items.length / 3) * $('.item').height() + "px")
      tmp = []
      for item in @items
        if tmp.indexOf(item.category) == -1
          @categories.push
            name:item.category
            active: false
          tmp.push item.category
      @changePositionItems()
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss">

.gallery {
  .input-model {
    ul {
      list-style: none;
      padding: 0;
      margin-bottom: 50px;
      text-align: center;
      li {
        transition: all 0.5s;
        color: grey;
        display: inline;
        cursor: pointer;
        padding: 3px 15px;
        text-transform: uppercase;
        &:hover {
          color: #111;
        }
        &.active {
          background-color: #111;
          color: #ececec;
        }
      }
    }
  }
  .gallery-items {
    position: relative;
    .item {
      position: absolute;
      height: auto;
      padding: 0;
    }
  }
}
</style>
