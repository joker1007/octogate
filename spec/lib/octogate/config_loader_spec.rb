require 'spec_helper'

describe Octogate::ConfigLoader do
  describe ".load_config" do
    subject { Octogate::ConfigLoader.load_config(config_file) }

    it "evaluate config on ConfigLoader instance binding" do
      expect { subject }.to change{ Octogate.config.token }.from(nil).to("token")
    end
  end
end
