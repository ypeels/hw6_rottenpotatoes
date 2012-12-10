class Hw2 < ActiveRecord::Migration
  def up
    # Figure 12.11 - KIND OF
    # rather, see paragraph after that figure: the moviegoer_id field in the movies table would need an index in order to speed up the query implied by movie.moviegoers
    #add_index 'moviegoers', 'review', :unique => true # these don't work
    #add_index 'movies', 'review', :unique => true
    
    # see db/schema.rb
    add_index 'reviews', 'movie_id'
    add_index 'reviews', 'moviegoer_id'
  end

  def down # JUST in case I have to roll this back...
    #remove_index 'moviegoers', 'review'
    #remove_index 'movies', 'review'
    remove_index 'reviews', 'movie_id'
    remove_index 'reviews', 'moviegoer_id'
  end

end
