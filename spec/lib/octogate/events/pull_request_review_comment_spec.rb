require 'spec_helper'

describe Octogate::Event::PullRequestReviewComment do
  describe ".parse" do
    subject { described_class.parse(read_payload(:pull_request_review_comment)) }
    it { should be_a described_class }

    it { expect(subject.comment).to be_a Octogate::GH::ReviewComment }
    it { expect(subject.comment.id).to eq 10384812 }
    it { expect(subject.comment.user).to be_a Octogate::GH::User }
    it { expect(subject.repository).to be_a Octogate::GH::Repository }
    it { expect(subject.comment.body).to eq "review comment test" }
  end

  describe "registered" do
    subject { Octogate::Event.get(:pull_request_review_comment) }

    it { should eq Octogate::Event::PullRequestReviewComment }
  end
end
