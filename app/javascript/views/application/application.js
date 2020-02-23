import Vue from 'vue/dist/vue.esm';

import movieList from './sections/movie_list.vue';

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
