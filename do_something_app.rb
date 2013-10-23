require 'sinatra'
require 'sinatra/activerecord'
require 'rack-flash'

require_relative 'models/user'
require_relative 'models/activity'
require_relative 'helpers/sessions_helper'

LOCAL_DB_URL = "postgres://localhost/do_something_dev"
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || LOCAL_DB_URL)

use Rack::Flash

enable :sessions


helpers do
  include SessionsHelper
end

get '/' do
  @current_user = User.find(session[:user_id]) if logged_in?
  flash_errors
  if logged_in?
    @activities = Activity.where(user_id: @current_user)
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
  new_activity.user_id = session[:user_id]
  if new_activity.save
    redirect('/')
  else
    flash[:notice] = new_activity.errors.messages
    redirect('/activities/new')
  end
end

post '/login' do
  @user = User.find_by_email(params[:sign_in_user][:email])
  verify_login(@user)
  redirect('/')
end

post '/signup' do
  user = User.new(params[:user])
  user.password = params[:user][:password]
  verify_user_create(user)
  redirect('/')
end

get '/logout' do
  session.clear
  redirect('/')
end

post '/delete/:id' do
  lame_activity = Activity.find(params[:id])
  lame_activity.destroy
  redirect '/'
end
