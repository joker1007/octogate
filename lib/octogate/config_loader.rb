module Octogate
  class ConfigLoader
    class << self
      def load_config(config_file)
        instance = new
        instance.instance_eval(File.read(config_file), config_file)
        instance.instance_eval do
          @_target_builders.each do |tb|
            Octogate.config.targets ||= {}
            Octogate.config.targets[tb.name] = tb.__to_target__
          end
        end
      end
    end

    def initialize
      @_target_builders = []
    end

    def token(token)
      Octogate.config.token = token
    end

    def target(name, &block)
      builder = TargetBuilder.new(name)
      builder.instance_eval(&block)
      @_target_builders << builder
    end

    def ca_file(ca_file)
      Octogate.config.ca_file = ca_file
    end

    def ssl_verify(verify)
      Octogate.config.ssl_verify = verify
    end
  end
end
