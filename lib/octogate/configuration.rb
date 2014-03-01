require "singleton"

module Octogate
  class Configuration
    include Singleton
    attr_accessor :targets, :token
  end
end
