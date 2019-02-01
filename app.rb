require 'sinatra/base'
require './lib/peep'
require './lib/user'

class Chitter < Sinatra::Base

get '/' do
  erb :login
end

post '/' do
  if User.sign_in_check(params[:user_email], params[:user_password])
    @user = User.sign_in(params[:user_email], params[:user_password])
    redirect '/feed'
  else
  redirect '/'
  end
end

get '/feed' do
  @peeps = Peep.all
  erb :index
end

post '/feed' do
  Peep.add(params[:add_peep])
  redirect '/feed'
end

get '/add_user' do
  erb :user_form
end

post '/add_user' do
  User.add(params[:add_username], params[:add_email], params[:add_password])
  redirect '/'
end

end
