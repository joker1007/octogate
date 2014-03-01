token "token"

target "jenkins" do
  hook_type [:push, :pull_request]
  url "http://targethost.dev/job/JobName"
  http_method :post

  parameter_type :query
  params key1: "value1", key2: "value2"

  match -> {
    event.ref =~ /master/
  }
end

target "jenkins2" do
  hook_type [:push, :pull_request]
  url "http://targethost2.dev/job/JobName"
  http_method :get

  parameter_type :json
  params key1: "value1", key2: "value2"

  match -> {
    !(event.ref =~ /master/)
  }
end
