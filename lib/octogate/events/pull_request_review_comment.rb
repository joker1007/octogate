require "octogate/events/base"
require "octogate/gh"

module Octogate
  class Event::PullRequestReviewComment < Event::Base
    register_event :pull_request_review_comment, self

    coerce_key :comment,      GH::ReviewComment
    coerce_key :repository,   GH::Repository
    coerce_key :sender,       GH::User

    class << self
      def parse(json)
        payload = Oj.load(json).deep_symbolize_keys

        new(payload)
      end
    end
  end
end
