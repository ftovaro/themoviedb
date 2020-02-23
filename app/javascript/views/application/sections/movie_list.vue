<! Template >
<template>
  <section>
    <div class="row no-gutters">
      <v-form ref="form" class="col-3" lazy-validation>
        <v-text-field
          v-model="movieId"
          label="Movie ID"
          :rules="MovieIdRules"
          class="p-0"
          required
        ></v-text-field>
      </v-form>
      <v-btn @click="addMovie" class="primary col-1 mx-5">Agregar</v-btn>
    </div>
    <div class="row">
      <movie-card v-for="movie in movies" class="col"
        v-bind:title="movie.title"
        v-bind:overview="movie.overview"
        v-bind:vote_count="movie.vote_count"
        v-bind:poster_path="movie.poster_path"
        v-bind:release_date="movie.release_date"
        v-bind:tmdb_id="movie.tmdb_id">
      </movie-card>
    </div>
  </section>
</template>

<! Script >
<script>
  import Routes from 'routes.js.erb';
  import moviesService from "../services/movies_service";
  import movieCard from "../components/movie_card";

  // import moment from 'moment';
  // moment.locale('es');

  export default {
    name: 'movie-list',
    components: {
      'movie-card': movieCard
    },
    props: {},
    mounted() {
      this.init();
    },
    data: () => ({
      movies: [],
      movieId: '',
      MovieIdRules: [
        v => !!v || 'Movie ID is required'
      ],
    }),
    computed: {
      railsRoutes() {
        return Routes;
      },
    },
    beforeMount(){},
    methods: {
      init(){
        const url = this.railsRoutes.api_v1_movies_path({format: 'json'});
        moviesService.loadMovies(url)
        .then((response) => {
          this.movies = response.data.movies;
        })
        .catch((error) => {
          console.log("error", error);
        });
      },
      addMovie(){
        if (this.$refs.form.validate()) {
          const url = this.railsRoutes.api_v1_movies_path({format: 'json'});
          moviesService.createMovie(url, { body: { movie_id: this.movieId }})
          .then((response) => {
            if (response.data.status == 200) {
              this.$parent.open("Movie created", "success");
              this.movies.push(response.data.movie);
            }
          })
          .catch((error) => {
            this.$parent.open(error.response.data.message, "error");
            console.log(error);
          })
        }
      }
    }
  }
</script>
