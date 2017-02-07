<!-- 
Composant form Vue js:
  inputs: Array[Object]
    ObjectInput: name, type, style (col), valid: validator.function, required
  name: Contenue Boutton submit
  success: contenue message après envoie
  slot: true a la fin faire la gestion dans le parent
 -->
 
<template lang="jade">
  form.container(method='POST', @submit.prevent='send', novalidate='')
    alert(:errors='errors', @send='initialize')
    success(v-if='success.length > 0', :message='success', :close='hasBeenSend', @send='initialize')
    .row
      div(v-for='input in inputs')
        .input-field.col(:class='input.style', v-if="input.type === 'text'")
          input.validate(type='text', :name='input.name', :id='input.name', v-model.trim='rows[input.name]')
          label(:for='input.name')
            div(v-if='!input.label')
              | {{ t(labelString(input.name)) }}
              span.error(v-if='input.required') *
            div(v-else='')
              | {{ t(labelString(input.label)) }}
              span.error(v-if='input.required') *
        .input-field.col(:class='input.style', v-if="input.type === 'password'")
          input.validate(type='password', :name='input.name', :id='input.name', v-model.trim='rows[input.name]')
          label(:for='input.name')
            div(v-if='!input.label')
              | {{ t(labelString(input.name)) }}
              span.error(v-if='input.required') *
            div(v-else='')
              | {{ t(labelString(input.label)) }}
              span.error(v-if='input.required') *
        .input-field.col(:class='input.style', v-if="input.type === 'email'")
          input.validate(type='email', :name='input.name', :id='input.name', v-model.trim='rows[input.name]')
          label(:for='input.name')
            div(v-if='!input.label')
              | {{ t(labelString(input.name)) }}
              span.error(v-if='input.required') *
            div(v-else='')
              | {{ t(labelString(input.label)) }}
              span.error(v-if='input.required') *
        .col(:class='input.style', v-if="input.type === 'radio'")
          ul.row
            li.inline(v-for='radio in input.option')
              input.with-gap(type='radio', :name='input.name', :id='radio', v-model.trim='rows[input.name]', :value='radio')
              label(:for='radio')
                | {{ t(labelString(radio)) }}
        .input-field.col(:class='input.style', v-if="input.type === 'select'")
          select(:id='input.name', v-model='rows[input.name]')
            option(:value='select', :selected='select === input.option[0]', :disabled='select === input.option[0]', v-for='select in input.option') {{ t(select) }}
        .col(:class='input.style', v-if="input.type === 'checkbox'")
          div(v-for='check in input.option')
            input(type='checkbox', :id='check', :value='check', v-model='rows[input.name]')
            label(:for='check') {{ t(labelString(check)) }}
        .switch.col(:class='input.style', v-if="input.type === 'switch'")
          label
            | {{ t(input.option[0]) }}
            input(type='checkbox', v-model='rows[input.name]')
            span.lever
            | {{ t(input.option[1]) }}
        .col.input-field(:class='input.style', v-if="input.type === 'date'")
          input.datepicker.pointer(type='date', :name='input.name', :id='input.name', v-model='rows[input.name]')
          label(:for='input.name')
            div(v-if='!input.label')
              | {{ t(labelString(input.name)) }}
              span.error(v-if='input.required') *
            div(v-else='')
              | {{ t(labelString(input.label)) }}
              span.error(v-if='input.required') *
        .input-field.col(:class='input.style', v-if="input.type === 'textarea'")
          i.material-icons.prefix mode_edit
          textarea.materialize-textarea(:name='input.name', :id='input.name', v-model.trim='rows[input.name]', @keyup='checkInput(input)')
          label(:for='input.name')
            div(v-if='!input.label')
              | {{ t(labelString(input.name)) }}
              span.error(v-if='input.required') *
            div(v-else='')
              | {{ t(labelString(input.label)) }}
              span.error(v-if='input.required') *
      slot
    div(v-bind:class="{ 'center-align' : center}")
      button.waves-effect.waves-light.btn(type='submit') {{ t(name) }}
</template>

<script lang="coffee">

  Alert = require('./Alert.vue')
  Success = require('./Success.vue')

  module.exports =  
    props:
      inputs:
        type: Array
        default: []
      name:
        type: String
        default: 'Form'
      success:
        type: String
        default: ''
      center:
        type: Boolean
        default: false
      clean:
        type: Boolean
        default: true
    components:
      Alert: Alert
      Success: Success
    inherit: true
    data: ->
      {
        rows: {}
        errors: []
        hasBeenSend: false
      }
    methods:
      send: ->
        @hasBeenSend = false
        @errors = []
        for key of @inputs
          if typeof @inputs[key].valid == 'function'
            if !@inputs[key].valid(@rows[@inputs[key].name])
              if @inputs[key].valid.name == 'isAlphanumeric'
                @errors.push 'Please enter a valid ' + @inputs[key].name
              if @inputs[key].valid.name == 'isEmail'
                @errors.push 'Your e-mail is not a valid one'
          if @inputs[key].type == 'select'
            if $(@inputs[key].name).val() == @inputs[key].option[0]
              @errors.push 'Please ' + @inputs[key].option[0]
            @rows[@inputs[key].name] = $(@inputs[key].name).val()
          if @inputs[key].type == 'date'
            @rows[@inputs[key].name] = $('.datepicker').val()
          if !@rows[@inputs[key].name] and @inputs[key].required and @inputs[key].type != 'switch'
            $('input[name=' + @inputs[key].name + ']').addClass 'invalid'
            @errors = [ 'Merci de remplir tous les champs' ]
          if @inputs[key].name.search("email") != -1
            @rows.email = @rows[@inputs[key].name]
        if @errors.length == 0
          @$emit 'send', @rows
          if @clean
            @rows = @eraseRows()
          @hasBeenSend = true
        return
      eraseRows: ->
        tmp = {}
        for key of @rows
          if typeof @rows[key] == 'string'
            tmp[key] = ''
          else if typeof @rows[key] == 'boolean'
            tmp[key] = false
          else
            tmp[key] = []
        tmp
      labelString: (str) ->
        str.charAt(0).toUpperCase() + str.slice(1)
      initialize: ->
        @errors = []
        @hasBeenSend = false
        return
    created: ->
      for key of @inputs
        if @inputs[key].type == 'checkbox'
          @rows[@inputs[key].name] = []
        else if @inputs[key].type == 'switch'
          @rows[@inputs[key].name] = false
        else
          @rows[@inputs[key].name] = ''
      return
</script>