#use Rack::MethodOverride

class TweetsController < ApplicationController

    get '/tweets' do 
        redirect_to_if_not_logged_in
        @tweets = Tweet.all 
        erb :'tweets/index'
    end

    get '/tweets/new' do 
        redirect_to_if_not_logged_in
        erb :'tweets/new'
    end

    post '/tweets' do
        @tweet = current_user.tweets.build(params)
        if @tweet.save
          redirect '/tweets'
        else
          redirect '/tweets/new'
        end
      end

    post '/tweets/new' do 
        @tweet = current_user.tweets.build(params)
        if @tweet.save 
        redirect '/tweets'
        else
        redirect '/tweets/new'
        end
    end
    
    get '/tweets/:id' do 
        redirect_to_if_not_logged_in
        @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/show'
    end

    get '/tweets/:id/edit' do 
        redirect_to_if_not_logged_in
        @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/edit'
    end

    patch '/tweets/:id/edit' do 
        redirect_to_if_not_logged_in
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet.id == current_user.id && params[:content] != ""
            @tweet.content = params[:content]
            @tweet.save 
            redirect '/tweets'
        else
            redirect "/tweets/#{@tweet.id}/edit"
        end
    end

    delete '/tweets/:id' do 
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && logged_in? && @tweet.user_id == current_user.id 
            @tweet.destroy 
        end
        redirect '/tweets'
    end

end