class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            redirect to '/tweets'
        else
            erb :'/users/create_user'
        end
    end

   post "/signup" do
    if !params.values.all? {|v| !v.blank?}
        redirect to '/signup'
      else
        @user = User.create(params)
        session[:user_id] = @user.id
        redirect to '/tweets'
      end
    end

    get '/login' do
        if logged_in?
            redirect to '/tweets'
        else
            erb :'/users/login'
        end
    end

    post '/login' do
        user = User.find_by(params[:id])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to '/tweets'
        else
            redirect to '/login'
        end
    end

    get '/logout' do
        if logged_in?
            session.clear
            redirect '/login'
        else
            redirect '/'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
        #binding.pry
    end

end
