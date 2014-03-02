# Octogate
[![Build Status](https://travis-ci.org/joker1007/octogate.png?branch=master)](https://travis-ci.org/joker1007/octogate)
[![Code Climate](https://codeclimate.com/github/joker1007/octogate.png)](https://codeclimate.com/github/joker1007/octogate)

Github hook proxy server

## Installation

Add this line to your application's Gemfile:

    gem 'octogate'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install octogate

## Usage

Write config.rb.

```ruby
token "token"

target "jenkins" do
  hook_type [:push, :pull_request]
  url "http://targethost.dev/job/CommitStage"
  http_method :get

  parameter_type :query
  params key1: "value1", key2: "value2"

  match -> {
    hook.ref =~ /master/
  }
end

target "jenkins2" do
  hook_type [:push, :pull_request]
  url "http://targethost2.dev/job/CommitStage"
  http_method :get

  parameter_type :json
  params key1: "value1", key2: "value2"

  match -> {
    !(hook.ref =~ /master/)
  }
end
```

And launch server.

```sh
% bundle exec octogate -h
Usage: octogate [options]
    -c config                        Set config file (default = ./config.rb)
    -p port                          Set port number (default = 4567)
    -o address                       Set address to bind (default = 0.0.0.0)

% bundle exec octogate -c config.rb
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/octogate/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
