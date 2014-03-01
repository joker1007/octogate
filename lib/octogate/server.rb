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

    # TODO: Fake Implementation
    event = Octogate::Event::Push.parse(params.delete(:token))
    Octogate::Client.new(event).send_to_targets

    return
  end
end
