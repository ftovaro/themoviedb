FactoryBot.define do
  factory :movie do
    title { "Toy Story" }
    overview { "Led by Woody, Andy's toys live happily in his room until Andy's birthday brings Buzz Lightyear onto the scene." }
    vote_count { 11664 }
    poster_path { "/rhIRbceoE9lR4veEXuwCC2wARtG.jpg" }
    release_date { "1995-10-30" }
    tmdb_id { 862 }
  end
end
