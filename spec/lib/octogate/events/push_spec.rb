require 'spec_helper'

describe Octogate::Event::Push do
  describe ".parse" do
    subject { described_class.parse("delivery_id", read_payload(:push)) }
    it { should be_a described_class }

    it { expect(subject.ref).to eq "refs/heads/master" }
    it { expect(subject.commits).to be_a Array }
    it { expect(subject.commits.first).to be_a Octogate::GH::Commit }
    it { expect(subject.head_commit).to be_a Octogate::GH::Commit }
    it { expect(subject.repository).to be_a Octogate::GH::Repository }
  end

  describe "registered" do
    subject { Octogate::Event.get(:push) }

    it { should eq Octogate::Event::Push }
  end
end
