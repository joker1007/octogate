$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'coveralls'
Coveralls.wear!

require 'octogate'
require 'tapp'
require 'tapp-awesome_print'
require 'webmock/rspec'
require 'rspec/collection_matchers'

Tapp.configure do |config|
  config.default_printer = :awesome_print
  config.report_caller   = true
end

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'

  config.before(:suite) do
    Octogate::ConfigLoader.load_config(config_file)
  end
end

def read_payload(name)
  File.read(File.join(File.dirname(File.expand_path(__FILE__)), "#{name}_payload.json"))
end

def config_file
  File.join(File.dirname(File.expand_path(__FILE__)), 'config_sample.rb')
end
