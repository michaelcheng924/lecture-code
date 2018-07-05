class ApplicationController < Sinatra::Base

  configure do
    # set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true

    enable :sessions
    set :session_secret, 'my-secret-key-123'

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

    erb :welcome
  end

  get '/login' do
    # how do we log people in?
  end

  delete '/logout' do
    # how do we log people out?
  end

end
