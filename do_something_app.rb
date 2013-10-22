require 'sinatra'
require 'sinatra/activerecord'
require_relative 'models/user'
require_relative 'models/activity'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || "postgres://localhost/do_something_dev")

enable :sessions

helpers do
  def logged_in?
    session[:user_id] ? true : false
  end
end

get '/' do
  @current_user = User.find(session[:user_id]) if logged_in?
  erb :index
end

get '/create_activity' do
  if logged_in?
    erb :create_activity
  else
    redirect '/'
  end
end

post '/create_activity' do
  Activity.create(params) if logged_in?
  redirect '/'
end

post '/signin' do
  @user = User.find_by_email(params[:sign_in_user][:email])
  if @user && (@user.password == params[:sign_in_user][:password])
    session[:user_id] = @user.id
    redirect '/'
  else
    redirect '/'
  end
end

post '/signup' do
  user = User.new(params[:user])
  user.password = params[:user][:password]
  user.save!
  session[:user_id] = user.id
  redirect('/')
end

get '/logout' do
  session.clear
  redirect('/')
end
