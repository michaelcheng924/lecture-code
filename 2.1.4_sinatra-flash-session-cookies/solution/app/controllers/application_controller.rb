class ApplicationController < Sinatra::Base

  configure do
    # set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true

    enable :sessions
    set :session_secret, 'dcbc0f1e27559fa3c3393633f67b43b11639b77b9f0437a140cf73131349551b1c5eed5a0cea6894c2fa37eb7d63667fa4b415bc664ae5eafbdcdb572e3b7fd6'

    # NOTE: This is how Sinatra recommends generating secret (http://sinatrarb.com/intro.html)
    # $ gem install sysrandom
    # Building native extensions.  This could take a while...
    # Successfully installed sysrandom-1.x
    # 1 gem installed
    #
    # $ ruby -e "require 'sysrandom/securerandom'; puts SecureRandom.hex(64)"
    # 99ae8af...snip...ec0f262ac

  end

  get '/' do
    session['welcomed'] = !session['welcomed']
    puts session
    puts "IN APP_CONTROLLER:\tSession Variable:\t#{session['welcomed']}"
binding.pry
    erb :welcome
  end

  get '/login' do
    erb :'static/login'
  end

  post '/sessions' do
    user = User.find_by(username: params[:username])
    
    if(user.password == params[:password])
      session[:user_id] = user.id
      redirect '/books'
    else
      redirect '/login'
    end
  end

  delete '/logout' do
    session[:user_id] = nil
    redirect '/'
  end

end
