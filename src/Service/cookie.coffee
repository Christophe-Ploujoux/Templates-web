module.exports =
  class Cookies
    constructor:(name)->
      @name = name
      return

    bake_cookie:(value)->
      cookie = [
        @name
        '='
        JSON.stringify(value)
      ].join('')
      document.cookie = cookie
      return

    read_cookie:->
      result = document.cookie.match(new RegExp(@name + '=([^;]+)'))
      result and (result = JSON.parse(result[1]))
      result

    delete_cookie:->
      document.cookie = [
        @name
        '=; expires=Thu, 01-Jan-1970 00:00:01 GMT'
        window.location.host.toString()
      ].join('')
      return