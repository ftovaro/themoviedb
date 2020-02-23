import axios from "axios";

class MoviesService {
  constructor() {}

  loadMovies(url, data) {
    return axios.get(url)
      .then((response) => {
        console.log(response.data);
        return response.data
      })
      .catch((error) => {
        console.log(error);
        return error
      });
  }
}

export default new MoviesService();
