require "sinatra"

class Octogate::Server < Sinatra::Base
  configure :production, :development do
    enable :logging
  end

  post '/:token' do
    unless Octogate.config.token == params[:token]
      status 403
      body "Access forbidden"
      return
    end

    p params
    # TODO: Fake Implementation
    event = Octogate::Event::Push.parse(Oj.load(params[:payload]))
    Octogate::Client.new(event).send_to_targets

    return
  end
end
