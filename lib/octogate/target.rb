module Octogate
  class Target < Model
    def include_event?(event)
      event_klasses = hook_type.nil? ? [] : hook_type.map do |name|
        Octogate::Event.get(name)
      end

      event_klasses.include?(event.is_a?(Octogate::Event::Base) ? event.class : event)
    end
  end
end
