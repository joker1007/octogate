require "octogate/version"

require "active_support/core_ext/hash"
require "active_support/core_ext/object"
require "active_support/core_ext/string"
require "oj"
require "hashie"

require "octogate/configuration"

module Octogate
  class << self
    REC_LIMIT = 100

    def config
      @config ||= Configuration.instance
    end

    def find_target(key)
      @config.targets.fetch(key)
    end

    def sent
      @sent ||= []
    end

    def received
      @received ||= []
    end

    def add_sent(target)
      sent.pop if sent.length > REC_LIMIT
      sent.unshift target
    end

    def add_received(event)
      received.pop if received.length > REC_LIMIT
      received.unshift event
    end
  end
end

require "octogate/model"
require "octogate/client"
require "octogate/config_loader"
require "octogate/target"
require "octogate/target_builder"
require "octogate/events"
require "octogate/sent_event"
require "octogate/gh"
