env = ENV["RACK_ENV"] || "development"
Bundler.require(:default, env)

class Octogate::Server < Sinatra::Base
  configure :production, :development do
    enable :logging
  end

  get '/:token' do
    params.tapp
  end
end
