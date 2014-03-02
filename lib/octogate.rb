require "octogate/version"

require "active_support/core_ext/hash"
require "active_support/core_ext/object"
require "oj"
require "hashie"

require "octogate/configuration"

module Octogate
  class << self
    def config
      @config ||= Configuration.instance
    end

    def find_target(key)
      @config.targets.fetch(key)
    end
  end
end

require "octogate/model"
require "octogate/client"
require "octogate/config_loader"
require "octogate/target"
require "octogate/target_builder"
require "octogate/events"
require "octogate/gh"
