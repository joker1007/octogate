token "token"
# ssl_verify false

target "jenkins" do
  hook_type [:push]
  url "http://targethost.dev/job/JobName"
  http_method :post

  parameter_type :query
  params key1: "value1", key2: "value2"

  match ->(event) {
    event.ref =~ /master/
  }
end

target "json_params" do
  hook_type [:push, :pull_request]
  url "http://targethost.dev/job/JobName"
  http_method :post

  parameter_type :json
  params key1: "value1", key2: "value2"

  match ->(event) {
    case event
    when Octogate::Event::PullRequest
      event.try(:pull_request).try(:head).try(:ref) =~ /json_params/
    when Octogate::Event::Push
      event.ref =~ /json_params/
    end
  }
end

target "block params" do

  hook_type [:push, :pull_request]
  url "http://targethost.dev/job/JobName"
  http_method :post

  parameter_type :query
  params ->(event) { {ref: event.ref, head_commit_id: event.head_commit.id, method: http_method} }

  match ->(event) {
    event.ref =~ /block_parameters/
  }
end

target "basic auth" do
  hook_type [:push, :pull_request]
  url "http://targethost.dev/job/JobName"
  http_method :post

  username "username_sample"
  password "password_sample"

  parameter_type :query
  params key1: "value1", key2: "value2"

  match ->(event) {
    event.ref =~ /basic_auth/
  }
end

target "always" do
  hook_type [:push, :pull_request]
  url "http://targethost.dev/job/JobName"
  http_method :post

  params always: "true"
end

target "always_push_only" do
  url "http://targethost.dev/job/JobName"
  http_method :post

  params always: "push_only"
end

target "never" do
  hook_type [:push, :pull_request]
  url "http://targethost.dev/job/JobName"
  http_method :post

  params never: "true"
  match false
end
