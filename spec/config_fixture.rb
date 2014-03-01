token "token"

target "jenkins" do
  hook_type [:push, :pull_request]
  url "http://localhost/hoge/job"
  http_method :get

  parameter_type :query
  params key1: "value1", key2: "value2"

  match -> {
    hook.ref =~ /master/
  }
end

target "jenkins2" do
  hook_type [:push, :pull_request]
  url "http://localhost/hoge/job"
  http_method :get

  parameter_type :json
  params key1: "value1", key2: "value2"

  match -> {
    hook.ref =~ /master/
  }
end
