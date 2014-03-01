require "faraday"
require "uri"

class Octogate::Client
  attr_reader :event

  def initialize(event)
    @event = event
  end

  def send_to_targets
    Octogate.config.targets.each do |t|
      condition = event.default_condition
      case t.match
      when Proc
        condition = condition && instance_exec(&t.match)
      when nil
      else
        condition = condition && !!t.match
      end

      if condition
        uri = URI(t.url)

        options = {url: t.url}
        options.merge!(ssl_options) if uri.scheme == "https"

        conn = Faraday.new(options) do |faraday|
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

  private

  def ssl_options
    if Octogate.config.ssl_verify
      Octogate.config.ca_file ? {ssl: {ca_file: Octogate.config.ca_file}} : {}
    else
      {ssl: {verify: false}}
    end
  end
end
