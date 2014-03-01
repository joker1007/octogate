require "singleton"

module Octogate
  class Configuration
    include Singleton
    attr_accessor :targets, :token, :ca_file, :ssl_verify

    def initialize
      @targets ||= []
      @ssl_verify = true
    end
  end
end
