token "token"

target "jenkins" do
  hook_type [:push, :pull_request]
  host "http://localhost/hoge/job"
  http_method :get

  type :params
  params key1: "value1", key2: "value2"

  match {
    hook.ref =~ /master/
  }
end
