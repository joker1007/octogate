require 'spec_helper'

describe Octogate::Client do
  describe "#sent_to_targets" do
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
      client.send_to_targets
      expect(WebMock).to have_requested(:post, "http://targethost.dev/job/JobName").with(body: {key1: "value1", key2: "value2"})
    end
  end
end
