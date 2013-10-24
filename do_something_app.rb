require 'sinatra'
require 'sinatra/activerecord'
require 'rack-flash'
require 'dotenv'
require 'omniauth/facebook'

Dotenv.load

require_relative 'models/user'
require_relative 'models/activity'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || "postgres://localhost/do_something_dev")

use OmniAuth::Builder do
  provider :facebook, ENV['APP_ID'], ENV['APP_SECRET']
end


enable :sessions
use Rack::Flash

helpers do
  def logged_in?
    session[:user_id] ? true : false
  end

  def create_session(user_id)
    session[:user_id] = user_id
  end
end

get '/' do
  @current_user = User.find(session[:user_id]) if logged_in?
  flash[:log_in_error]
  flash[:sign_up_error]
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
  if @user && (@user.password == params[:sign_in_user][:password])
    create_session(@user.id)
    session[:user_id] = @user.id
  else
    flash[:log_in_error] = "Incorrect login. Please try again."
  end
  redirect('/')
end

post '/signup' do
  user = User.new(params[:user])
  user.password = params[:user][:password]
  if user.save
    create_session(user.id)
  else
    flash[:sign_up_error] = user.errors.messages
  end
  redirect('/')
end

get '/logout' do
  session.clear
  redirect('/')
end

post '/delete/:id' do
  if logged_in?
    lame_activity = Activity.find(params[:id])
    lame_activity.destroy
  end
  redirect '/'
end

get '/auth/facebook/callback' do
  facebook_user = {email: request.env['omniauth.auth']['info'].email,
                   first_name: request.env['omniauth.auth']['info'].first_name,
                   facebook_id: request.env['omniauth.auth'].uid
                 }

  current_facebook_user = User.find_by_email(facebook_user[:email])

  if current_facebook_user
    if User.find_by_facebook_id(facebook_user[:facebook_id])
      create_session(current_facebook_user.id)
    else
      current_facebook_user.facebook_id = facebook_user[:facebook_id]
      current_facebook_user.save
      create_session(current_facebook_user.id)
    end
  else
    new_user = User.new(facebook_user)
    new_user.password = SecureRandom.hex
    new_user.save
    create_session(new_user.id)
  end
  redirect('/')
end
