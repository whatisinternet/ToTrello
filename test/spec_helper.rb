require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'totrello'
require 'digest/sha1'

TRELLO_DEVELOPER_PUBLIC_KEY ||= ENV['TRELLO_DEVELOPER_PUBLIC_KEY']
TRELLO_MEMBER_TOKEN ||= ENV['TRELLO_MEMBER_TOKEN']