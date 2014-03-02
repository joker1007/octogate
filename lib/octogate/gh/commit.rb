require "octogate/gh/user"

module Octogate
  class GH::Commit < Model
    coerce_key :author, GH::User
    coerce_key :committer, GH::User
  end
end
