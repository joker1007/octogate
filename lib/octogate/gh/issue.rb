require "octogate/gh/user"

module Octogate
  class GH::Issue < Model
    coerce_key :user,     GH::User
    coerce_key :assignee, GH::User

    def initialize(*args)
      super
      self.labels = labels.nil? ? [] : labels.map do |l|
        GH::Label.new(l)
      end
    end
  end
end
