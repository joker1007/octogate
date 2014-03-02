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

    event_name = request.env["HTTP_X_GITHUB_EVENT"]
    event_klass = Octogate::Event.get(event_name)
    event = event_klass.parse(params[:payload])
    Octogate::Client.new(event).request_to_targets

    return
  end
end
