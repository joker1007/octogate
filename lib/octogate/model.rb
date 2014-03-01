module Octogate::Model
  def initialize(**args)
    args.each do |k, v|
      send("instance_variable_set", "@#{k}", v)
    end
  end
end
