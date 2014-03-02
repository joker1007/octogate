module Octogate
  class Target < Model
    def include_event?(event_klass)
      event_klasses = hook_type.nil? ? [] : hook_type.map do |name|
        Octogate::Event.get(name)
      end

      event_klasses.include?(event_klass)
    end
  end
end
