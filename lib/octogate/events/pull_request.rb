require "octogate/events/base"
require "octogate/gh"

module Octogate
  class Event::PullRequest < Event::Base
    register_event :pull_request, self

    coerce_key :pull_request, GH::PullRequest
    coerce_key :repository,   GH::Repository
    coerce_key :sender,       GH::User

    class << self
      def parse(json)
        payload = Oj.load(json).deep_symbolize_keys

        new(payload)
      end
    end

    def default_condition
      !deleted
    end
  end
end
