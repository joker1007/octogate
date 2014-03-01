module Octogate
  class Target
    include Model

    attr_reader :url, :username, :password, :hook_type, :http_method, :parameter_type, :params, :match
  end
end
