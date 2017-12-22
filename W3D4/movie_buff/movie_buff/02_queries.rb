def eighties_b_movies
  # List all the movies from 1980-1989 with scores falling between
  # 3 and 5 (inclusive).
  # Show the id, title, year, and score.
  Movie.select(:id, :title, :yr, :score).where(yr: 1980..1989, score: 3..5)
end

def bad_years
  # List the years in which a movie with a rating above 8 was not released.
  Movie.group(:yr).having('MAX(score) < 8').pluck(:yr)
end

def cast_list(title)
  # List all the actors for a particular movie, given the title.
  # Sort the results by starring order (ord). Show the actor id and name.
  Actor.select(:id, :name).joins(:movies).where(movies: {title: title}).order('castings.ord')
end

def vanity_projects
  # List the title of all movies in which the director also appeared
  # as the starring actor.
  # Show the movie id and title and director's name.

  # Note: Directors appear in the 'actors' table.
  Movie.select('movies.id,movies.title,actors.name').joins(:actors).where('actors.id = director_id AND castings.ord = 1')

  # Movie.select('movies.id,movies.title,actors.name').joins(:director).where('actors.id = director_id AND castings.ord = 1')


end
# SELECT movies.id,movies.title,actors.name FROM "movies" INNER JOIN "castings" ON "movies"."id" = "castings"."movie_id" INNER JOIN "actors" ON "actors"."id" = "movies"."director_id" WHERE "castings"."ord" = "1"
# SELECT movies.id, movies.title,actors.name
# FROM movies
# INNER JOIN castings ON castings.movie_id = movies.id
# INNER JOIN actors ON actors.id = movies.director_id
# WHERE castings.ord = 1
# AND actors.id = movies.director_id

def most_supportive
  # Find the two actors with the largest number of non-starring roles.
  # Show each actor's id, name and number of supporting roles.

  # Actor.select(:id, :name, :)
  Actor.select('actors.id, actors.name, COUNT(castings.*) AS roles').joins(:castings).where('castings.ord != 1').group(:id).order('COUNT(castings.*) DESC').limit(2)

  # SELECT
  #   actors.id, actors.name, COUNT(castings.*)
  # FROM
  #   actors
  # JOIN castings ON
  #   castings.actor_id = actors.id
  # WHERE
  #   castings.ord != 1
  # GROUP BY
  #   actors.id
  #

end
