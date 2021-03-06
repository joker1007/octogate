require "octogate/events/base"
require "octogate/gh"

module Octogate
  class Event::Push < Event::Base
    register_event :push, self

    coerce_key :head_commit, GH::Commit
    coerce_key :repository,  GH::Repository

    class << self
      def parse(delivery_id, json)
        payload = Oj.load(json).deep_symbolize_keys

        commits = payload[:commits].nil? ? [] : payload.delete(:commits).map do |c|
          GH::Commit.new(c.symbolize_keys)
        end

        attrs = payload.merge(delivery_id: delivery_id, commits: commits)

        new(attrs)
      end
    end

    def default_condition
      !deleted
    end
  end
end
