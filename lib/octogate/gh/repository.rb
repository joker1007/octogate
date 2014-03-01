module Octogate
  class GH::Repository
    include Model

    attr_reader :id, :name, :description, :homepage, :watchers, :stargazers, :forks, :fork, :size, :owner, :private, :open_issues, :has_issues, :has_downloads, :has_wiki, :language, :created_at, :pushed_at, :master_branch, :pusher

    def initialize(**args)
      new_args = args.deep_symbolize_keys
      new_args[:owner] = GH::User.new(new_args[:owner]) if new_args[:owner]
      super(new_args)
    end
  end
end
