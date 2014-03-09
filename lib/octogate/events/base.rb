require "oj"

module Octogate
  class Event::Base < Octogate::Model
    class << self
      def register_event(name, klass)
        Octogate::Event.register_event(name, klass)
        self.instance_eval do
          define_method :name do
            name
          end
        end
      end

      def parse(delivery_id, json)
        payload = Oj.load(json).deep_symbolize_keys

        new(payload.merge(delivery_id: delivery_id))
      end
    end

    def default_condition
      true
    end
  end
end
