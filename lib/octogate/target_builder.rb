module Octogate
  class TargetBuilder
    def initialize
      @url            = nil
      @hook_type      = [:push]
      @http_method    = :get
      @parameter_type = :query
      @match          = nil
    end

    def url(url)
      @url = url
    end

    def hook_type(types)
      @hook_type = Array(types)
    end

    def http_method(http_method)
      @http_method = http_method
    end

    def parameter_type(parameter_type)
      @parameter_type = parameter_type
    end

    def match(match_proc)
      @match = match_proc
    end

    def params(params)
      @params = params
    end

    def __to_target__
      Target.new(
        url: @url,
        hook_type: @hook_type,
        http_method: @http_method,
        parameter_type: @parameter_type,
        params: @params,
        match: @match,
      )
    end
  end
end
