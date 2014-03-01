module Octogate
  class Event::Push < Event::Base
    attr_reader :ref, :after, :before, :created, :deleted, :forced, :compare, :commits, :head_commit, :repository, :pusher
    class << self
      def parse(json)
        payload = Oj.load(json).deep_symbolize_keys

        commits = payload[:commits].map do |c|
          GH::Commit.new(c.symbolize_keys)
        end

        head_commit = payload[:head_commit] ? GH::Commit.new(payload[:head_commit]) : nil

        repository = GH::Repository.new(payload[:repository])

        new(
          ref: payload[:ref],
          after: payload[:after],
          before: payload[:before],
          created: payload[:created],
          deleted: payload[:deleted],
          forced: payload[:forced],
          compare: payload[:compare],
          commits: commits,
          head_commit: head_commit,
          repository: repository,
        )
      end
    end

    def default_condition
      !deleted
    end
  end
end
