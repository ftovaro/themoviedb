## TheMovieDBftovaro ##
This is an API where you can store **movies** that are published in [TheMovieDB](https://www.themoviedb.org/).

Once the movies are stored in our DB, you can easily search and filter the movies.

## Installation ##

First of all, this app was created with **Ruby 2.6.4** and **Rails 6.0.2.1**. We use **Postgresql** as DB so get that ready before anything, also, we use **Node 10.14.1**. 

After you have cloned the project, go inside the folder and run `bundle install`, then `rails db:create db:migrate db:seed`.

Once done, you can start the server with `rails s`

## Testing ##

This project uses **Rspec** for testing, we have models, controllers, and services tests, don't forget to check them out!.

To run the tests just run `rspec spec`

## Deployment ##

This API is currently online and deployed in **Heroku** and can be used by anybody. 

URL: `https://moviedbftovaro.herokuapp.com/`

## Wiki ##

Find more about this cool API and its endpoints [here](https://github.com/ftovaro/themoviedb/wiki)
