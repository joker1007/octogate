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

## Event Capability

- Push Event
- PullRequest Event

## Usage

Write config.rb.

```ruby
token "token_string"

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
# if event type is push and event.ref contains "master",
# octogate requests "http://targethost.dev/job/JobName" via POST method, request body is {key1: "value1, key2: "value2"} params

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
# if event type is push or pull_request, and ref name contains "json_params",
# octogate requests "http://targethost.dev/job/JobName" via POST method, body is {key1: "value1, key2: "value2"} as JSON FORMAT

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

## Config DSL Reference

### Global definitions
| name       | arg              | description                                                                           |
| -------    | --------         | ------------                                                                          |
| token      | String           | set token used as endpoint url.                                                       |
| ssl_verify | Boolean          | if set false, make disable SSL verification. (if target uses self-signed certificate) |
| target     | String and Block | String is target name. Block is target definition block.                              |

### Target definitions
| name             | arg                         | description                                                                                                     |
| ---------------- | -----------------           | ----------------------------------------------------------------------------------------------------            |
| hook_type        | Array (value is event type) | set hook event (default = [:push])                                                                              |
| url              | String                      | set destination URL                                                                                             |
| http_method      | Symbol                      | set HTTP method when octogate request target.                                                                   |
| parameter_type   | :query or :json             | :query = use form parameter or get query parameter, :json = serialize payload by json format (default = :query) |
| params           | Hash or Proc                | set payload parameters. if pass Proc instance, call with event instance and use result                          |
| match            | Boolean or Proc             | if this value is set, then transfer process is executed only when the evaluation result is truthy.              |

### Event type 
| name          | class name                   |
| -------       | ------------------           |
| :push         | Octogate::Event::Push        |
| :pull_request | Octogate::Event::PullRequest |

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
