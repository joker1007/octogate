require "octogate/gh/user"

module Octogate
  class GH::Issue < Model
    coerce_key :user, GH::User
  end
end
