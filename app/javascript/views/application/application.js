import Vue from 'vue/dist/vue.esm';
import Vuetify from 'vuetify'
import VueToast from 'vue-toast-notification';

import 'vuetify/dist/vuetify.min.css'
import 'vue-toast-notification/dist/index.css';

import movieList from './sections/movie_list.vue';

Vue.use(VueToast);
Vue.use(Vuetify)

/* Init Vue App */
document.addEventListener('DOMContentLoaded', () => {

  const el = document.body.querySelector('#application-layout');
  const vm = new Vue({
    el,
    vuetify: new Vuetify(),
    components: {
      'movie-list': movieList
    },
    methods: {
      open(message, type) {
          this.$toast.open({
              message: message,
              type: type,
              duration: 2000,
              dismissible: true
          })
      }
    }
  });
});
