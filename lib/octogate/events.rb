require "active_support/core_ext/hash"
module Octogate
  module Event
    autoload :Push        , "octogate/events/push"
    autoload :PullRequest , "octogate/events/pull_request"

    class << self
      def register_event(name, klass)
        @events ||= {}.with_indifferent_access
        @events[name] = klass
      end

      def get(name)
        @events.fetch(name) do
          raise NotRegisteredEvent.new(name)
        end
      end
    end
  end

  class NotRegisteredEvent < StandardError; end
end
