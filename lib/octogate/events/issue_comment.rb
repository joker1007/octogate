require "octogate/events/base"
require "octogate/gh"

module Octogate
  class Event::IssueComment < Event::Base
    register_event :issue_comment, self

    coerce_key :issue,        GH::Issue
    coerce_key :comment,      GH::IssueComment
    coerce_key :repository,   GH::Repository
    coerce_key :sender,       GH::User
  end
end
