class TweetsController < ApplicationController

    get '/tweets' do 
        @tweets = Tweet.all
        if logged_in?
            @user = current_user
            erb :'tweets/index'
        else
            redirect to '/login'
        end
    end

    get '/tweets/new' do 
        if logged_in?
            erb :'tweets/new'
        else
            redirect to '/login'
        end
    end

    post '/tweets/new' do 
        @user = current_user
        @tweet = Tweet.create(
            content: params[:content],
            user_id: @user.id
        )
        if @tweet.save 
            redirect to '/tweets'
        else
            redirect to '/tweets/new'
        end
    end


end
