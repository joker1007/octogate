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
    case event_name
    when "push"
      event = Octogate::Event::Push.parse(params[:payload])
      Octogate::Client.new(event).send_to_targets
    end

    return
  end
end
