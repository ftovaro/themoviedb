<! Template >
<template>
  <section>
    <v-app>
      <div class="row no-gutters">
        <v-form ref="form" class="col-2" lazy-validation>
          <v-text-field
            v-model="movieId"
            label="Movie ID"
            :rules="MovieIdRules"
            class="p-0"
            required
          ></v-text-field>
        </v-form>
        <v-btn @click="addMovie" color="success" class="col-1 mx-5">Agregar</v-btn>
      </div>
      <div class="row no-gutters">
        <v-form ref="form" class="col-12 row no-gutters">
          <v-text-field
            v-model="movieTitle"
            label="Movie Title"
            class="p-0 col-2 mr-2"
          ></v-text-field>
          <v-text-field
            v-model="movieOverview"
            label="Movie Overview"
            class="p-0 col-2 mx-2"
          ></v-text-field>
          <v-text-field
            v-model="movieVoteCount"
            label="Movie Vote Count"
            class="p-0 col-2 mx-2"
            type="number"
          ></v-text-field>
          <v-btn @click="searchMovie" color="primary" class="col-1 mx-5">Buscar</v-btn>
        </v-form>
      </div>
      <div class="row no-gutters">
        <v-select
          v-model="select"
          :items="items"
          item-text="key"
          item-value="value"
          label="Filter"
          class="col-3"
          persistent-hint
          return-object
          single-line
        ></v-select>
        <v-btn @click="filter" color="secondary" class="col-1 mx-5">Filter</v-btn>
      </div>
      <div class="row no-gutters">
        <v-btn @click="init" color="warning" class="col-1 mx-5">Reset</v-btn>
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
    </v-app>
  </section>
</template>

<! Script >
<script>
  import Routes from 'routes.js.erb';
  import moviesService from "../services/movies_service";
  import movieCard from "../components/movie_card";

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
      movieTitle: '',
      movieOverview: '',
      movieVoteCount: '',
      MovieIdRules: [
        v => !!v || 'Movie ID is required'
      ],
      select: { key: '', value: '' },
      items: [
        { key: '', value: '' },
        { key: 'Tomorrow', value: 'tomorrow' },
        { key: 'Next week', value: 'next-week' },
        { key: 'Next month', value: 'next-month' },
        { key: 'Custom range', value: 'custom-range' },
      ],
    }),
    computed: {
      railsRoutes() {
        return Routes;
      },
    },
    watch: {
      select(newValue) {
        if (newValue) {
          console.log(newValue.value);
        }
      },
    },
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
      },
      searchMovie(){
        const url = this.railsRoutes.search_api_v1_movies_path({format: 'json'});
        moviesService.searchMovie(url, { title: this.movieTitle, overview: this.movieOverview , vote_count: this.movieVoteCount })
        .then((response) => {
          if (response.data.status == 200) {
            this.$parent.open(`Movies found: ${response.data.movies.length}`, "success");
            this.movies = response.data.movies;
          }
        })
        .catch((error) => {
          this.$parent.open(error.response.data.message, "error");
          console.log(error);
        })
      },
      filter(){
        console.log(this.select.value);
      }
    }
  }
</script>
