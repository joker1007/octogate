require "octogate/gh/user"

module Octogate
  class GH::ReviewComment < Model
    coerce_key :user, GH::User
  end
end
