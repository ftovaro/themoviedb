import axios from "axios";

class MoviesService {
  constructor() {}

  loadMovies(url) {
    return axios.get(url);
  }

  createMovie(url, movieData) {
    return axios.post(url, movieData, { headers: {'X-Api-Key': 'SMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c'}})
  }

  searchMovie(url, movieData) {
    return axios.get(encodeURI(url), { params: movieData, headers: {'X-Api-Key': 'SMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c'}})
  }

  filterMovie(url, movieData) {
    return axios.get(encodeURI(url), { params: movieData, headers: {'X-Api-Key': 'SMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c'}})
  }
}

export default new MoviesService();
