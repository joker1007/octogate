require "faraday"
require "uri"

class Octogate::Client
  attr_reader :event

  def initialize(event)
    @event = event
  end

  def send_to_targets
    Octogate.config.targets.each do |t|
      if instance_exec(&t.match)
        uri = URI(t.url)
        conn = Faraday.new(url: t.url) do |faraday|
          faraday.request  :url_encoded
          faraday.response :logger if ENV["RACK_ENV"] == "development" || ENV["RACK_ENV"] == "production"
          faraday.adapter  Faraday.default_adapter
        end

        conn.basic_auth(t.username, t.password) if t.username && t.password

        case t.http_method
        when :get
          conn.get do |req|
            req.url uri.path
            t.params.each do |k, v|
              req.params[k] = v
            end
          end
        when :post
          conn.post uri.path, t.params
        end
      end
    end
  end
end
