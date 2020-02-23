<! Template >
<template>
  <section class="row no-gutters">
    <v-card max-width="244" class="mx-auto">
      <v-list-item>
        <v-list-item-content>
          <v-list-item-title class="headline">{{title}}</v-list-item-title>
          <v-list-item-subtitle>Release date: {{release_date}}</v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
      <v-img v-bind:src="`https://image.tmdb.org/t/p/w500${poster_path}`" height="194"></v-img>
      <v-card-text class="py-2">Vote count: {{vote_count}}</v-card-text>
      <v-card-actions>
        <v-btn text color="deep-purple accent-4">More info</v-btn>
      </v-card-actions>
      <v-card-text class="py-2">{{ overview.length < 50 ? overview : overview.substring(0,50) + "..."}}</v-card-text>
    </v-card>
  </section>
</template>

<! Script >
<script>
  // import moment from 'moment';
  // moment.locale('es');

  export default {
    name: 'movie-card',
    components: {},
    props: {
      title: String,
      overview: String,
      vote_count: Number,
      poster_path: String,
      release_date: String,
      tmdb_id: Number
    },
    mounted() {
    },
    data: () => ({
      items: [
        {
          color: '#1F7087',
          src: 'https://cdn.vuetifyjs.com/images/cards/foster.jpg',
          title: 'Supermodel',
          artist: 'Foster the People',
        },
        {
          color: '#952175',
          src: 'https://cdn.vuetifyjs.com/images/cards/halcyon.png',
          title: 'Halcyon Days',
          artist: 'Ellie Goulding',
        },
      ],
    }),
    computed: {
    },
    beforeMount(){},
    methods: {}
  }
</script>
