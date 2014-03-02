module Octogate
  module GH
    autoload :Commit      , "octogate/gh/commit"
    autoload :Repository  , "octogate/gh/repository"
    autoload :User        , "octogate/gh/user"
    autoload :PullRequest , "octogate/gh/pull_request"
  end
end

require "octogate/gh/commit"
require "octogate/gh/repository"
require "octogate/gh/user"
