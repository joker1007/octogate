require "faraday"
require "uri"
require "active_support/core_ext/object"
require "octogate/transfer_request"

class Octogate::Client
  attr_reader :event

  def initialize(event)
    @event = event
  end

  def request_to_targets
    Octogate.config.targets.each do |target_name, t|
      if match_target?(t)
        request(t)
      end
    end
  end

  def request(target)
    uri = URI(target.url)

    options = {url: target.url}
    options.merge!(ssl_options) if uri.scheme == "https"

    conn = build_connection(options, target.username, target.password)

    params = target.params.is_a?(Proc) ?
      target.instance_exec(event, &target.params) : target.params

    case target.http_method
    when :get
      Octogate::TransferRequest::GET.new(conn)
        .do_request(url: uri.path, params: params)
    when :post
      Octogate::TransferRequest::POST.new(conn)
        .do_request(url: uri.path, params: params, parameter_type: target.parameter_type)
    end
  end

  private

  def match_target?(target)
    condition = event.default_condition && target.include_event?(event)
    case target.match
    when Proc
      condition && target.instance_exec(event, &target.match)
    when nil
      condition
    else
      condition && !!target.match
    end
  end

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

