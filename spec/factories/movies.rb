FactoryBot.define do
  factory :movie do
    title { "Toy Story" }
    overview { "Led by Woody, Andy's toys live happily in his room until Andy's birthday brings Buzz Lightyear onto the scene." }
    vote_count { 11664 }
    poster_path { "/rhIRbceoE9lR4veEXuwCC2wARtG.jpg" }
    release_date { Date.today.strftime("%Y-%m-%d") }
    tmdb_id { 862 }
  end
end
