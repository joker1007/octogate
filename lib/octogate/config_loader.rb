module Octogate
  class ConfigLoader
    class << self
      def load_config(config_file)
        instance = new
        instance.instance_eval(File.read(config_file), config_file)
      end
    end

    def token(token)
      Octogate.config.token = token
    end

    def target(name, &block)
    end
  end
end
