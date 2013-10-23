require 'sinatra/activerecord'
require 'faker'


require_relative '../models/user'
require_relative '../models/activity'

%x(dropdb do_something_dev)
%x(createdb do_something_dev)
%x(rake db:migrate)

# creates 20 users in the database
20.times do
  first_name = Faker::Name.first_name
  email = Faker::Internet.email
  User.create(
      first_name: first_name,
      email: email,
      password: 'password'
    )
end

ACTIVITY_COST = ["$", "$$", "$$$"]

CATEGORY = ["Food", "Extreme", "Sport", "Park", "Event", "Nightlife", "Other"]

RATING = [1,2,3,4,5]

100.times do
  title = Faker::Lorem.sentence(word_count=rand(4..8))
  city = Faker::Address.city
  cost = ACTIVITY_COST.sample
  category = CATEGORY.sample
  comment = Faker::Lorem.sentences(sentence_count=rand(1..3)).join
  rating = RATING.sample.to_s
  user_id = rand(1..20)

  Activity.create(
    title: title,
    city: city,
    cost: cost,
    category: category,
    comment: comment,
    rating: rating,
    user_id: user_id
    )
end
