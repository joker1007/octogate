require 'spec_helper'

describe Octogate::Target do
  describe "#include_event?" do
    let(:target) { described_class.new(hook_type: [:push]) }

    context "hook_type include Given Event" do
      subject { target.include_event?(Octogate::Event::Push) }

      it { should be_true }
    end

    context "hook_type not include Given Event" do
      subject { target.include_event?(Octogate::Event::PullRequest) }

      it { should be_false }
    end
  end
end
