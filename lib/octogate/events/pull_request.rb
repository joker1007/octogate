require "octogate/events/base"
require "octogate/gh"

module Octogate
  class Event::PullRequest < Event::Base
    register_event :pull_request, self

    coerce_key :pull_request, GH::PullRequest
    coerce_key :repository,   GH::Repository
    coerce_key :sender,       GH::User

    def default_condition
      action != "closed"
    end
  end
end
