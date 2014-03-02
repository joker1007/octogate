require 'spec_helper'

describe Octogate::Event::PullRequest do
  describe ".parse" do
    subject { described_class.parse(read_payload(:pull_request)) }
    it { should be_a described_class }

    it { expect(subject.action).to eq "opened" }
    it { expect(subject.number).to eq 2 }
    it { expect(subject.pull_request).to be_a Octogate::GH::PullRequest }
    it { expect(subject.pull_request.base).to be_a Octogate::GH::Commit }
    it { expect(subject.pull_request.head).to be_a Octogate::GH::Commit }
  end
end
