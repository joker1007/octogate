require 'spec_helper'

describe Octogate::ConfigLoader do
  describe ".load_config" do
    before do
      Octogate.config.token = nil
      Octogate.config.targets = {}
    end

    subject { Octogate::ConfigLoader.load_config(config_file) }

    it "evaluate config on ConfigLoader instance binding" do
      from_token = Octogate.config.token
      from_targets = Octogate.config.targets

      expect(from_token).to be_nil
      expect(from_targets).to eq({})

      subject

      expect(Octogate.config.token).to eq("token")
      expect(Octogate.config.targets).to have(7).item
      expect(Octogate.config.targets["jenkins"]).to be_a Octogate::Target
    end
  end
end
