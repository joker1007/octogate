require 'spec_helper'

describe Octogate::Client do
  describe "#request_to_targets" do
    let(:event) { Octogate::Event::Push.parse(push_payload) }

    before do
      stub_request(:post, "http://targethost.dev/job/JobName")
        .to_return(:status => 200, :body => "", :headers => {})
    end

    after do
      WebMock.reset!
    end

    it "request to target host" do
      client = Octogate::Client.new(event)
      client.request_to_targets
      expect(WebMock).to have_requested(:post, "http://targethost.dev/job/JobName").with(body: {key1: "value1", key2: "value2"})
      expect(WebMock).to have_requested(:post, "http://targethost.dev/job/JobName").with(body: {always: "true"})
      expect(WebMock).not_to have_requested(:post, "http://targethost.dev/job/JobName").with(body: {never: "true"})
    end

    describe "matching rule" do
      it "request only targets that match rule" do
        event = Octogate::Event::Push.new(ref: "json_params")
        client = Octogate::Client.new(event)
        expect(client).to receive(:request).with(Octogate.find_target("json_params"))
        expect(client).to receive(:request).with(Octogate.find_target("always"))
        client.request_to_targets
      end
    end
  end

  describe "#request" do
    before do
      stub_request(:post, "http://targethost.dev/job/JobName")
        .to_return(:status => 200, :body => "", :headers => {})
    end

    after do
      WebMock.reset!
    end

    it "can use event attributes on request parameter" do
      event = Octogate::Event::Push.new(
        ref: "refs/heads/block_parameters",
        head_commit: Octogate::GH::Commit.new(id: "dummy commit id")
      )

      client = Octogate::Client.new(event)
      client.request(Octogate.find_target("block params"))
      expect(WebMock).to have_requested(:post, "http://targethost.dev/job/JobName").with(body: {ref: event.ref, head_commit_id: event.head_commit.id})
    end

    it "request always to target that have no match rule" do
      event = Octogate::Event::Push.new(
        ref: "refs/heads/match_rule_nothing",
      )

      client = Octogate::Client.new(event)
      client.request(Octogate.find_target("always"))
      expect(WebMock).to have_requested(:post, "http://targethost.dev/job/JobName").with(body: {always: "true"})
    end

    it "can request with json parameters" do
      event = Octogate::Event::Push.new(
        ref: "refs/heads/json_params",
      )

      client = Octogate::Client.new(event)
      client.request(Octogate.find_target("json_params"))
      expect(WebMock).to have_requested(:post, "http://targethost.dev/job/JobName").with(body: {key1: "value1", key2: "value2"}, headers: {'Content-Type' => 'application/json'})
    end

    it "can use basic authentication" do
      stub_request(:post, "http://username_sample:password_sample@targethost.dev/job/JobName")
        .to_return(:status => 200, :body => "", :headers => {})

      event = Octogate::Event::Push.new(
        ref: "refs/heads/basic_auth",
      )

      client = Octogate::Client.new(event)
      client.request(Octogate.find_target("basic auth"))
      expect(WebMock).to have_requested(:post, "http://username_sample:password_sample@targethost.dev/job/JobName").with(body: {key1: "value1", key2: "value2"})
    end
  end
end
