class UsersController < ApplicationController

    get '/signup' do 
        if logged_in?
            redirect to '/tweets'
        else
            erb :"/users/new"
        end
    end

    post '/signup' do 
        @user = User.create(
            username: params[:username],
            email: params[:email],
            password: params[:password])
        @user.save
        redirect '/tweets/#{@user.id}'
    end

    get '/login' do
        if logged_in?
          redirect to '/tweets'
        else
          erb :"/users/login"
        end
      end

end
