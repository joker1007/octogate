module Octogate
  class Event::Base < Octogate::Model
    def default_condition
      true
    end
  end
end
