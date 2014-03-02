require "octogate/gh/user"

module Octogate
  class GH::Repository < Model
    coerce_key :owner, GH::User
  end
end
