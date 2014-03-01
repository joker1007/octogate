require "octogate/version"

require "active_support/core_ext/hash"
require "active_support/core_ext/object"
require "oj"

require "octogate/configuration"

module Octogate
  class << self
    def config
      @config ||= Configuration.instance
    end
  end
end

require "octogate/config_loader"
require "octogate/model"
require "octogate/events"
require "octogate/gh"
