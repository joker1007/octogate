# Octogate
[![Gem Version](https://badge.fury.io/rb/octogate.png)](http://badge.fury.io/rb/octogate)
[![Build Status](https://travis-ci.org/joker1007/octogate.png?branch=master)](https://travis-ci.org/joker1007/octogate)
[![Code Climate](https://codeclimate.com/github/joker1007/octogate.png)](https://codeclimate.com/github/joker1007/octogate)
[![Coverage Status](https://coveralls.io/repos/joker1007/octogate/badge.png)](https://coveralls.io/r/joker1007/octogate)

Github hook proxy server of Sinatra Framework.

You can write about request destination in Ruby DSL

## Installation

Add this line to your application's Gemfile:

    gem 'octogate'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install octogate

## Requirements

- Ruby-2.0.0 or later

## Usage

Write config.rb.

```ruby
token "token_string"

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
```

More sample is [hear](https://github.com/joker1007/octogate/blob/master/spec/config_sample.rb)

And launch server.

```sh
% bundle exec octogate -h
Usage: octogate [options]
    -c config                        Set config file (default = ./config.rb)
    -p port                          Set port number (default = 4567)
    -o address                       Set address to bind (default = 0.0.0.0)

% bundle exec octogate -c config.rb
# => Endpoint is http://hostname:4567/token_string
```

## Event Capability

- Push Event
- PullRequest Event

## Hosting on Heroku

Create directory and bundle init.

```sh
% mkdir your-app-dir
% cd your-app-dir
% bundle init
```

Write `Gemfile` and `bundle install`.

```ruby
gem "octogate"
gem "thin"
```

```sh
bundle install --path .bundle
```

Write `Procfile`

```
web: bundle exec octogate -c ./config.rb -p $PORT
```

Write config at `./config.rb`

```sh
% vim config.rb
```

Create git repository.

```sh
% git init .
% echo ".bundle" > .gitignore
% git commit -am "init"
```

Create Heroku app and push it.

```sh
% heroku create your-app-name
% git push heroku master
```

## Contributing

1. Fork it ( https://github.com/joker1007/octogate/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
