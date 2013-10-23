require 'sinatra'
require 'sinatra/activerecord'
require 'rack-flash'


require_relative 'models/user'
require_relative 'models/activity'
require_relative 'helpers/session_helper'

LOCAL_DATABASE_LOCATION = "postgres://localhost/do_something_dev"
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || LOCAL_DATABASE_LOCATION)

enable :sessions
use Rack::Flash


helpers do
  include SessionHelper
end

get '/' do
  flash[:log_in_error]
  flash[:sign_up_error]
  if logged_in?
    @activities = Activity.where(user_id: active_user.id)
  else
    @activities = Activity.last(5)
  end
  erb :index
end

get '/activities/new' do
  if logged_in?
    if flash[:notice]
      @errors = flash[:notice]
    end
    erb :create_activity
  else
    redirect('/')
  end
end

post '/activities' do
  new_activity = Activity.new(params)
  new_activity.user_id = active_user.id
  if new_activity.save
    redirect('/')
  else
    flash[:notice] = new_activity.errors.messages
    redirect('/activities/new')
  end
end

post '/login' do
  @user = User.find_by_email(params[:sign_in_user][:email])
  if @user && (@user.password == params[:sign_in_user][:password])
    make_active(@user)
  else
    flash[:log_in_error] = "Incorrect login. Please try again."  
  end
  redirect('/')
end

post '/signup' do
  user = User.new(params[:user])
  user.password = params[:user][:password]
  if user.save
    make_active(user)
  else
    flash[:sign_up_error] = user.errors.messages
  end
  redirect('/')
end

get '/logout' do
  logout
  redirect('/')
end

post '/delete/:id' do
  if logged_in?
    lame_activity = Activity.find(params[:id])
    lame_activity.destroy
  end
  redirect '/'
end
