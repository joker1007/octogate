module Octogate
  class Event::Base < Octogate::Model
    class << self
      def register_event(name, klass)
        Octogate::Event.register_event(name, klass)
      end
    end

    def default_condition
      true
    end
  end
end
