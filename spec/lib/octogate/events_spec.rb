require 'spec_helper'

describe Octogate::Event do
  describe ".get" do
    it "returns registerd event class" do
      expect(Octogate::Event.get(:push)).to eq Octogate::Event::Push
    end
  end
end
