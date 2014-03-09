require "oj"

module Octogate
  class SentEvent < Model
    class << self
      def build(event, target, params, sent_at = Time.now)
        new(
          event: event,
          target_name: target.name,
          target_url: target.url,
          sent_payload: params,
          sent_at: sent_at
        )
      end
    end

    def delivery_id
      event.delivery_id
    end

    def name
      event.name
    end
  end
end
