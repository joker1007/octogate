require "octogate/gh/user"

module Octogate
  class GH::IssueComment < Model
    coerce_key :user, GH::User
  end
end
