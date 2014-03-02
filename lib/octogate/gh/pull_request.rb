require "octogate/gh/user"

module Octogate
  class GH::PullRequest < Model
    coerce_key :user, GH::User
    coerce_key :head, GH::Commit
    coerce_key :base, GH::Commit
  end
end
