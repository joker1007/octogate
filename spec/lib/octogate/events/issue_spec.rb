require 'spec_helper'

describe Octogate::Event::Issue do
  describe ".parse" do
    subject { described_class.parse(read_payload(:issues)) }
    it { should be_a described_class }

    it { expect(subject.action).to eq "opened" }
    it { expect(subject.issue).to be_a Octogate::GH::Issue }
    it { expect(subject.issue.id).to eq 28599630 }
    it { expect(subject.issue.labels.first).to be_a Octogate::GH::Label }
    it { expect(subject.repository).to be_a Octogate::GH::Repository }
  end

  describe "registered" do
    subject { Octogate::Event.get(:issues) }

    it { should eq Octogate::Event::Issue }
  end
end
