class ApplicationController < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    redirect '/students'
  end

end