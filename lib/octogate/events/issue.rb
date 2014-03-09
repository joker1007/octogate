require "octogate/events/base"
require "octogate/gh"

module Octogate
  class Event::Issue < Event::Base
    register_event :issues, self

    coerce_key :issue,        GH::Issue
    coerce_key :repository,   GH::Repository
    coerce_key :sender,       GH::User
  end
end
