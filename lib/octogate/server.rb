require "sinatra"
require "haml"

class Octogate::Server < Sinatra::Base
  set :root, File.join(File.expand_path(File.dirname(__FILE__)), "..", "..", "web")
  set :public_folder, Proc.new { File.expand_path("#{root}/assets") }
  set :views, Proc.new { "#{root}/views" }
  set :haml, :format => :html5

  configure :production, :development do
    enable :logging
  end

  get '/:token/received_events' do
    unless Octogate.config.token == params[:token]
      status 403
      body "Access forbidden"
      return
    end

    received = Octogate.received
    haml :received_events, locals: {received: received}
  end

  get '/:token/sent_events' do
    unless Octogate.config.token == params[:token]
      status 403
      body "Access forbidden"
      return
    end

    sent = Octogate.sent
    haml :sent_events, locals: {sent: sent}
  end

  post '/:token' do
    unless Octogate.config.token == params[:token]
      status 403
      body "Access forbidden"
      return
    end

    event = build_event_from(request)
    Octogate.add_received(event)
    Octogate::Client.new(event).request_to_targets

    return
  end

  def build_event_from(request)
    delivery_id = request.env["HTTP_X_GITHUB_DELIVERY"]
    event_name = request.env["HTTP_X_GITHUB_EVENT"]
    event_klass = Octogate::Event.get(event_name)
    event = event_klass.parse(delivery_id, params[:payload])
    event.received_at = Time.now
    event
  end
end
