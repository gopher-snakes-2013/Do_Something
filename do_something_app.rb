require 'sinatra'
require 'sinatra/activerecord'


class User < ActiveRecord::Base
end

get '/' do
  erb :index
end

get '/create_activity' do
 "hello world!"
end

post '/signup' do
  redirect('/')
end
