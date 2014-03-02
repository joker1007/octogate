require "faraday"
require "uri"

class Octogate::Client
  attr_reader :event

  def initialize(event)
    @event = event
  end

  def request_to_targets
    Octogate.config.targets.each do |t|
      condition = event.default_condition
      case t.match
      when Proc
        condition = condition && instance_exec(event, &t.match)
      when nil
      else
        condition = condition && !!t.match
      end

      if condition
        request(t)
      end
    end
  end

  def request(t)
    uri = URI(t.url)

    options = {url: t.url}
    options.merge!(ssl_options) if uri.scheme == "https"

    conn = build_connection(options, t.username, t.password)

    params = t.params.respond_to?(:call) ? t.params.call(event) : t.params

    case t.http_method
    when :get
      conn.get do |req|
        req.url uri.path
        params.each do |k, v|
          req.params[k] = v
        end
      end
    when :post
      if t.parameter_type == :json
        conn.post uri.path do |req|
          req.headers['Content-Type'] = 'application/json'
          req.body = Oj.dump(params)
        end
      else
        conn.post uri.path, params
      end
    end
  end

  private

  def build_connection(options, username = nil, password = nil)
    conn = Faraday.new(options) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger if ENV["RACK_ENV"] == "development" || ENV["RACK_ENV"] == "production"
      faraday.adapter  Faraday.default_adapter
    end
    conn.basic_auth(username, password) if username && password
    conn
  end

  def ssl_options
    if Octogate.config.ssl_verify
      Octogate.config.ca_file ? {ssl: {ca_file: Octogate.config.ca_file}} : {}
    else
      {ssl: {verify: false}}
    end
  end
end
