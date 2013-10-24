http://www.yelp.com/developers

Yelp Search API

Search for local businesses. 

Available Params:
search term, such as "food" or "nightlife". If term isn't included, everything is searched.
limi, limit the number of results
sort, sort mode 0=best matched (default), 1= disntace, 2=highest rated
location, combination of "address, neighborhood, city, state or zip, optional country"

Example: http://api.yelp.com/v2/search?term=food&location=San+Francisco

Returns hash with info like name, category, address, yelp rating IMG.

Requires authorization. Ruby examples given on Yelp's Github: https://github.com/Yelp/yelp-api/blob/master/v2/ruby/example.rb