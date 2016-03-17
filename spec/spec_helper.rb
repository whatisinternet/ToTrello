require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
TRELLO_DEVELOPER_PUBLIC_KEY ||= ENV['TRELLO_DEVELOPER_PUBLIC_KEY']
TRELLO_MEMBER_TOKEN ||= ENV['TRELLO_MEMBER_TOKEN']

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

# require 'totrello/totrello'
require 'totrello'
