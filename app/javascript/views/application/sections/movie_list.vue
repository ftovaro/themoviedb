<! Template >
<template>
  <section class="row">
    <div class="col">
      ddd
    </div>
    <div class="col">
      ppp
    </div>
  </section>
</template>

<! Script >
<script>
  import Routes from 'routes.js.erb';
  import moviesService from "../services/movies_service";

  // import moment from 'moment';
  // moment.locale('es');

  export default {
    name: 'movie-list',
    components: {},
    props: {},
    mounted() {
      this.init();
    },
    data: () => ({
      init(){
        const url = this.railsRoutes.api_v1_movies_path({format: 'json'});
        moviesService.loadMovies(url);
      }
    }),
    computed: {
      railsRoutes() {
        return Routes;
      },
    },
    beforeMount(){},
    methods: {}
  }
</script>
