class TweetsController < ApplicationController
    get "/tweets" do
        if !Helpers.is_logged_in?(session)
            redirect "/login"
        else
            @tweets = Tweet.all
            
            erb :"tweets/tweets"
        end
    end

    get "/tweets/new" do
        if !Helpers.is_logged_in?(session)
            redirect "/login"
        else
            erb :"tweets/create_tweet"
        end
    end

    post "/tweets" do
        if Helpers.is_logged_in?(session)
            if params[:content] == ""
                redirect "/tweets/new"
            else
                tweet = current_user.tweets.build(content: params[:content])
                
                if tweet.save
                    redirect "/tweets/#{tweet.id}"
                else
                    redirect "/tweets/new"
                end
            end
        else
            redirect "/login"
        end
    end

    get "/tweets/:id" do
        if Helpers.is_logged_in?(session)
          @tweet = Tweet.find_by_id(params[:id])
          erb :"tweets/show_tweet"
        else
          redirect to "/login"
        end
    end

    get "/tweets/:id/edit" do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find_by_id(params[:id])

            if @tweet && @tweet.user == current_user
                erb :"tweets/edit_tweet"
            else
                redirect to "/tweets"
            end
        else
            redirect to "/login"
        end
    end

    patch "/tweets/:id" do
        if Helpers.is_logged_in?(session)
            if params[:content] == ""
                redirect to "/tweets/#{params[:id]}/edit"
            else
                @tweet = Tweet.find_by_id(params[:id])

                if @tweet && @tweet.user == current_user
                    if @tweet.update(content: params[:content])
                        redirect to "/tweets/#{@tweet.id}"
                    else
                        redirect to "/tweets/#{@tweet.id}/edit"
                    end
                else
                    redirect to "/tweets"
                end
            end
        else
            redirect to "/login"
        end
    end

    delete "/tweets/:id/delete" do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find_by_id(params[:id])

            if @tweet && @tweet.user == current_user
                @tweet.delete
            end
            redirect to "/tweets"
        else
            redirect to "/login"
        end
    end
end
