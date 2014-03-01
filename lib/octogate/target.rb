module Octogate
  class Target
    include Model

    attr_reader :url, :hook_type, :http_method, :parameter_type, :params, :match
  end
end
