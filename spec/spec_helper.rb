$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'octogate'
require 'tapp'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end

def push_payload
  File.read(File.join(File.dirname(File.expand_path(__FILE__)), 'push_payload.json'))
end

def config_file
  File.join(File.dirname(File.expand_path(__FILE__)), 'config_fixture.rb')
end
