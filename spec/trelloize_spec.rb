require 'spec_helper'
require 'totrello/trelloize'
require 'totrello/trello_config'
require 'totrello/todos'
require 'digest/sha1'

describe Trelloize do

  before(:all) do
    @test_dir = "#{Dir.pwd}/spec/fixtures"
    @test_file = "fixture.rb"
    @config = TrelloConfig.new
    @todos = Todos.new
    @todo = @todos.todos_for_file("#{@test_dir}/#{@test_file}", @config)[0]
  end

  describe 'description' do

    before(:each) do
      @trelloize = Trelloize.new
    end

    it 'responds to description' do
      expect(@trelloize).to respond_to(:description)
    end

    it 'accepts a todo and a config' do
      expect(@trelloize).to respond_to(:description).with(2).arguments
    end

    it 'returns a string' do
      expect(@trelloize.description(@todo, @config)).to be_a(String)
    end

  end

  describe 'find_and_create_cards_from_todos' do
    before(:each) do
      @trelloize = Trelloize.new
    end

    it 'responds to find_and_create_cards_from_todos' do
      expect(@trelloize).to respond_to(:find_and_create_cards_from_todos)
    end

    it 'find_and_create_cards_from_todos accepts two arguments' do
      expect(@trelloize).to respond_to(:find_and_create_cards_from_todos).with(2).arguments
    end
  end

end
