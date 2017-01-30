// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.

// =============== Base libraries integration ==================
import Vue from 'vue'
import VueResource from 'vue-resource'
import VueTranslate from 'vue-translate-plugin'
import Materials from "vue-materials"

Vue.use(VueResource)
Vue.use(VueTranslate)
Vue.use(Materials)

import store from './store'
import router from './router'

(function(d, s, id){
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement(s); js.id = id;
    js.src = "https://connect.facebook.net/en_US/sdk.js#version=v2.2&appId=360554577631913&status=true&cookie=true&xfbml=true";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

// ======================= Base Component ======================
import App from './App'
import Cookie from './Service/cookies'

router.beforeEach((to, from, next) => {
	if (to.path.indexOf("/dashboard") !== -1) {
		if (!localStorage.token) {
      return next('/')	
		}
	}
	return next()
})

new Vue({
  mounted: function() {
    this.$http.get("http://localhost:8000/api/config/template")
    .then((res) => {
      this.$store.commit("config", res.data)
      document.title = res.data.title
      $('meta[name="description"]').attr("content", res.data.description)
    }, (err) => {
      console.log(err)
    });
  },
  router,
  store,
  el: '#app',
  render: h => h(App)
})
