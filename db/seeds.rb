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
  user = User.create(
      first_name: first_name,
      email: email,
      password: 'password'
    )
end

