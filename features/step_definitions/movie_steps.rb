# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create! movie
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split.each do |rating|
    step %Q{I #{uncheck}check "ratings_#{rating}"}
  end
end

Then /I should( not)? see the following movies: (.*)/ do |notsee, movies|
  movies.split(',').map{|x| x.strip}.each do |movie|
    step %Q{I should#{notsee} see "#{movie}"}
  end
end

Then /^I should not see any of the movies$/ do
  Movie.all.map{|x| x.title}.each do |movie|
    step %Q{I should not see "#{movie}"}
  end
end

Then /^I should see all of the movies$/ do
  Movie.all.map{|x| x.title}.each do |movie|
    step %Q{I should see "#{movie}"}
  end
end

Then /^I should see all movies in alphabetical order$/ do
  names = Movie.all.map{|x| x.title}.sort
  0.upto(names.size - 1) do |i|
    step %Q{I should see "#{names[i]}" before "#{names[i+1]}"}
  end
end

Then /^I should see all movies in increasing order of release date$/ do
  items = Movie.all.map{|x| x.release_date}.sort
  0.upto(items.size - 1) do |i|
    step %Q{I should see "#{items[i]}" before "#{items[i+1]}"}
  end
end

Then /^I should see "([^"])" before "([^"])"$/ do |elm0, elm1|
  page.content.should =~ /#{elm0}.*#{elm1}/
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |arg1, arg2|
  step %Q{I should see "#{arg1}"}
  step %Q{I should see "#{arg2}"}
end
