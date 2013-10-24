require 'sinatra'
require 'sinatra/activerecord'
require 'rack-flash'
require 'json'

require_relative 'models/user'
require_relative 'models/activity'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || "postgres://localhost/do_something_dev")

enable :sessions
use Rack::Flash

helpers do
  def logged_in?
    session[:user_id] ? true : false
  end

  def random_activity_id(user_id)
    activities = Activity.where(user_id: user_id)
    activity_id = activities.sample.id
  end

  def find_activity(id)
    Activity.find(id)
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

post '/activities/select' do
  activity_id = random_activity_id(session[:user_id])
  activity_id.to_json
end

post '/login' do
  @user = User.find_by_email(params[:sign_in_user][:email])
  if @user && (@user.password == params[:sign_in_user][:password])
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
    session[:user_id] = user.id
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
