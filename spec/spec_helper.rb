require 'codeclimate-test-reporter'
require 'pry'
require 'dotenv'
require 'vcr'
require 'webmock/rspec'
require 'bundler/setup'
CodeClimate::TestReporter.start

Bundler.setup
Dotenv.load

TRELLO_DEVELOPER_PUBLIC_KEY ||= ENV['TRELLO_DEVELOPER_PUBLIC_KEY']
TRELLO_MEMBER_TOKEN ||= ENV['TRELLO_MEMBER_TOKEN']

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = true
end

# require 'totrello/totrello'
require 'totrello'

RSpec.configure do |c|
  # c.profile_examples = true
  # c.fail_fast = 1
end
