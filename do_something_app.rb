require 'sinatra'
require 'sinatra/activerecord'

enable :sessions

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || "postgres://localhost/do_something_dev")

class User < ActiveRecord::Base
end

get '/' do
  if session[:user_id]
    @user = User.find(session[:user_id])
  end
  erb :index
end

get '/create_activity' do
 "hello world!"
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
