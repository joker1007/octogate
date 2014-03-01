module Octogate
  class Event::Base
    include Octogate::Model

    def default_condition
      true
    end
  end
end
