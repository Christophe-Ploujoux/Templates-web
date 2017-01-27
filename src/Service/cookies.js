module.exports = class Cookies {
  constructor(name) {
    this.name = name
  }

  bake_cookie(value) {
    var cookie = [this.name, '=', JSON.stringify(value)].join('');
    document.cookie = cookie;
  }

  read_cookie() {
   var result = document.cookie.match(new RegExp(this.name + '=([^;]+)'));
   result && (result = JSON.parse(result[1]))
   return result;
  }

  delete_cookie() {
    document.cookie = [this.name, '=; expires=Thu, 01-Jan-1970 00:00:01 GMT', window.location.host.toString()].join('');
  }
}