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

    get '/tweets/:id' do 
        if logged_in?
            @tweet = Tweet.find_by(user_id: params[:id])
            erb :'tweets/show'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id/edit' do 
        @tweet = Tweet.find_by(user_id: params[:id])
        if logged_in? && @tweet.user == current_user
            erb :'tweets/edit'
        else
            redirect to '/login'
        end
    end

    patch '/tweets/:id/edit' do 
        @tweet = Tweet.find_by(user_id: params[:id])
        @user = current_user
        if @tweet.update(content: params[:content], user: @user)
            redirect to '/tweets'
        else
            redirect to '/tweets/#{@tweets.id}/edit'
        end
    end

    delete '/tweets/:id/delete' do 
        @tweet = Tweet.find_by(user_id: params[:id])
        @user = current_user
        if @tweet && @tweet.destroy
            redirect to '/tweets'
        else
            redirect to '/tweets/#{@tweets.id}'
        end
    end

end
