require 'sinatra'
require 'sinatra/activerecord'
require 'rack-flash'

require_relative 'models/activity'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || "postgres://localhost/do_something_dev")

enable :sessions
use Rack::Flash


class User < ActiveRecord::Base
end

get '/' do
  if session[:user_id]
    @current_user = User.find(session[:user_id])
  end
  erb :index
end

get '/create_activity' do
  if flash[:notice]
    @errors = flash[:notice]
  end
 erb :create_activity
end

post '/create_activity' do
  new_activity = Activity.new(params)
  if new_activity.save
    redirect('/')
  else
    flash[:notice] = new_activity.errors.messages
    redirect('/create_activity')
  end
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
