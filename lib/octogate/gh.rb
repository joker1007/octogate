module Octogate
  module GH
    autoload :Commit       , "octogate/gh/commit"
    autoload :Repository   , "octogate/gh/repository"
    autoload :User         , "octogate/gh/user"
    autoload :PullRequest  , "octogate/gh/pull_request"
    autoload :Issue        , "octogate/gh/issue"
    autoload :Label        , "octogate/gh/label"
    autoload :IssueComment , "octogate/gh/issue_comment"
    autoload :ReviewComment, "octogate/gh/review_comment"
  end
end
