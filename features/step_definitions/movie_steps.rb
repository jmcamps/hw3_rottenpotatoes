# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)    
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.  
  assert page.body =~ /#{e1}.*#{e2}/m 
  #flunk "Unimplemented" 
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/, /).each do |option|    
    step %Q{I #{uncheck}check "ratings_#{option}"}
  end 
end

Then /^I should see all of the movies$/ do 
  rows = page.all("table#movies tr").count-1  
  assert rows == Movie.all.count  
end

Then /^I should not see any movie$/ do 
  rows = page.all("table#movies tr").count-1  
  assert rows == 0  
end
