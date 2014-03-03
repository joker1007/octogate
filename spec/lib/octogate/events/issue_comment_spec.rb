require 'spec_helper'

describe Octogate::Event::IssueComment do
  describe ".parse" do
    subject { described_class.parse(read_payload(:issue_comment)) }
    it { should be_a described_class }

    it { expect(subject.action).to eq "created" }
    it { expect(subject.issue).to be_a Octogate::GH::Issue }
    it { expect(subject.issue.id).to eq 28599636 }
    it { expect(subject.issue.labels.first).to be_a Octogate::GH::Label }
    it { expect(subject.repository).to be_a Octogate::GH::Repository }
    it { expect(subject.comment).to be_a Octogate::GH::IssueComment }
    it { expect(subject.comment.body).to eq "IssueとIssue Commentを追加する。" }
  end

  describe "registered" do
    subject { Octogate::Event.get(:issue_comment) }

    it { should eq Octogate::Event::IssueComment }
  end
end
