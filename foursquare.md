https://developer.foursquare.com/

Userless Venue Search or Explore Requests

Does not require OAuth. 

Search Venues - returns a list of venues matching a search term.
Can use "near" parameter to include a city/state. 

https://api.foursquare.com/v2/venues/search?near=San Francisco, CA => JSON Object

Explore Venues - returns a list of popular venues
Also uses "near" paramter
https://api.foursquare.com/v2/venues/explore?near=San Francisco, CA => JSON Object

Returned JSON Object includes lots of info:
Location, Phone, Category, # of Check Ins, etc.

Possibly use this to "Do Something New" and return a random location.