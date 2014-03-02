require "octogate/gh/user"
require "octogate/gh/repository"

module Octogate
  class GH::Commit < Model
    coerce_key :user, GH::User
    coerce_key :repo, GH::Repository
    coerce_key :author, GH::User
    coerce_key :committer, GH::User
  end
end
