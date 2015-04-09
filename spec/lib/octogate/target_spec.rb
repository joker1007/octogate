require 'spec_helper'

describe Octogate::Target do
  describe "#include_event?" do
    let(:target) { described_class.new(hook_type: [:push]) }

    context "hook_type include Given Event" do
      subject { target.include_event?(Octogate::Event::Push) }

      it { should be_truthy }
    end

    context "hook_type not include Given Event" do
      subject { target.include_event?(Octogate::Event::PullRequest) }

      it { should be_falsey }
    end

    context "Given event instance" do
      subject { target.include_event?(Octogate::Event::Push.new()) }

      it { should be_truthy }
    end
  end
end
