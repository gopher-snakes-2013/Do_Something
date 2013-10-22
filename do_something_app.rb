require 'sinatra'
require 'sinatra/activerecord'
require_relative 'models/activity'

$LOAD_PATH.unshift(File.expand_path('.'))
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || "postgres://localhost/do_something_dev")


get '/' do
  erb :index
end

get '/create_activity' do
 erb :create_activity
end

post '/create_activity' do
  Activity.create!(params)
  p params
  redirect '/'
end
