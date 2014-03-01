module Octogate
  class GH::Commit
    include Model

    attr_reader :id, :distinct, :message, :timestamp, :url, :author, :commiter, :added, :removed, :modified

    def initialize(**args)
      new_args = args.deep_symbolize_keys
      new_args[:author] = GH::User.new(new_args[:author]) if new_args[:author]
      new_args[:committer] = GH::User.new(new_args[:committer]) if new_args[:committer]
      super(new_args)
    end
  end
end
