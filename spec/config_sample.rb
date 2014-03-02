token "token"
# ssl_verify false

target "jenkins" do
  hook_type [:push, :pull_request]
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
    event.ref =~ /json_params/
  }
end

target "block params" do

  hook_type [:push, :pull_request]
  url "http://targethost.dev/job/JobName"
  http_method :post

  parameter_type :query
  params ->(event) { {ref: event.ref, head_commit_id: event.head_commit.id} }

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

target "never" do
  hook_type [:push, :pull_request]
  url "http://targethost.dev/job/JobName"
  http_method :post

  params never: "true"
  match false
end
