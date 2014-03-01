module Octogate
  class GH::User
    include Model

    attr_reader :name, :email, :username
  end
end
