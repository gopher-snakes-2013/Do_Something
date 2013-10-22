require 'sinatra'
require 'sinatra/activerecord'

require_relative 'models/activity'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || "postgres://localhost/do_something_dev")

enable :sessions


class User < ActiveRecord::Base
end

get '/' do
  if session[:user_id]
    @current_user = User.find(session[:user_id])
  end
  erb :index
end

get '/create_activity' do
 erb :create_activity
end

post '/create_activity' do
  Activity.create(params)
  redirect '/'
end

post '/signup' do
  user = User.create(params[:user])
  session[:user_id] = user.id
  redirect('/')
end

get '/logout' do
  session.clear
  redirect('/')
end
