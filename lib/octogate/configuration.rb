require "singleton"

module Octogate
  class Configuration
    include Singleton
    attr_accessor :targets, :token

    def initialize
      @targets ||= []
    end
  end
end
