require "octogate/gh"

module Octogate
  class Event::Push < Event::Base
    coerce_key :head_commit, GH::Commit
    coerce_key :repository, GH::Repository

    class << self
      def parse(json)
        payload = Oj.load(json).deep_symbolize_keys

        commits = payload[:commits].nil? ? [] : payload.delete(:commits).map do |c|
          GH::Commit.new(c.symbolize_keys)
        end

        attrs = payload.merge(commits: commits)

        new(attrs)
      end
    end

    def default_condition
      !deleted
    end
  end
end
