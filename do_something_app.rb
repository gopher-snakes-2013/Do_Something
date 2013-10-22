require 'sinatra'
require 'sinatra/activerecord'
require_relative 'models/user'
require_relative 'models/activity'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || "postgres://localhost/do_something_dev")

enable :sessions




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
  user = User.new(params[:user])
  user.password = params[:password]
  user.save!
  session[:user_id] = user.id
  redirect('/')
end

get '/logout' do
  session.clear
  redirect('/')
end
