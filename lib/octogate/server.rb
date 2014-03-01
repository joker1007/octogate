require "sinatra"

class Octogate::Server < Sinatra::Base
  configure :production, :development do
    enable :logging
  end

  get '/:token' do
    unless Octogate.config.token == params[:token]
      status 403
      body "Access forbidden"
      return
    end
  end
end
