import Vue from 'vue/dist/vue.esm';
import vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'


import movieList from './sections/movie_list.vue';

Vue.use(vuetify)
/* Init Vue App */
document.addEventListener('DOMContentLoaded', () => {

  const el = document.body.querySelector('#application-layout');
  const vm = new Vue({
    el,
    components: {
      'movie-list': movieList
    },
    methods: {}
  });
});
