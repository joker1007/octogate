$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'octogate'
require 'tapp'
require 'webmock/rspec'

Tapp.configure do |config|
  config.default_printer = :awesome_print
  config.report_caller   = true
end

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
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
