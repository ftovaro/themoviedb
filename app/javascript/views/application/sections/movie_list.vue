<! Template >
<template>
  <section class="row">
    <v-card
      max-width="344"
      class="mx-auto"
    >
      <v-list-item>
        <v-list-item-avatar color="grey"></v-list-item-avatar>
        <v-list-item-content>
          <v-list-item-title class="headline">Our Changing Planet</v-list-item-title>
          <v-list-item-subtitle>by Kurt Wagner</v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>

      <v-img
        src="https://cdn.vuetifyjs.com/images/cards/mountain.jpg"
        height="194"
      ></v-img>

      <v-card-text>
        Visit ten places on our planet that are undergoing the biggest changes today.
      </v-card-text>

      <v-card-actions>
        <v-btn
          text
          color="deep-purple accent-4"
        >
          Read
        </v-btn>
        <v-btn
          text
          color="deep-purple accent-4"
        >
          Bookmark
        </v-btn>
        <v-spacer></v-spacer>
        <v-btn icon>
          <v-icon>mdi-heart</v-icon>
        </v-btn>
        <v-btn icon>
          <v-icon>mdi-share-variant</v-icon>
        </v-btn>
      </v-card-actions>
    </v-card>
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
