require 'spec_helper'
require 'totrello/todos'
require 'totrello/config'

describe Todos do
  before(:all) do
    @test_dir = "#{Dir.pwd}/spec/fixtures"
    @test_file = "fixture.rb"
    @config = Config.new
  end

  describe 'load_files' do

    before(:each) do
      @todos = Todos.new
    end

    it 'responds to load_files' do
      expect(@todos).to respond_to(:load_files)
    end

    it 'responds to load_files with a directory path and config' do
      expect(@todos).to respond_to(:load_files).with(2).arguments
    end

    it 'returns an array of file strings' do
      expect(@todos.load_files(@test_dir, @config)).to be_a(Array)
    end

    it 'each item must be a string' do
      files= @todos.load_files(@test_dir, @config)
      files.each do |f|
        expect(f).to be_a(String)
      end
    end

  end

  describe 'lines_with_index_for_file' do

    before(:each) do
      @todos = Todos.new
    end

    it 'responds to lines_with_index_for_file' do
      expect(@todos).to respond_to(:lines_with_index_for_file)
    end

    it 'responds to lines_with_index_for_file for one argument' do
      expect(@todos).to respond_to(:lines_with_index_for_file).with(1).arguments
    end

    it 'returns an array' do
      expect(@todos.lines_with_index_for_file("#{@test_dir}/#{@test_file}")).to be_a(Array)
    end

    it 'returns an array of todo objects' do
      files= @todos.lines_with_index_for_file("#{@test_dir}/#{@test_file}")
      files.each do |f|
        expect(f).to be_a(Object)
      end
    end

  end

  describe 'todo?' do

    before(:each) do
      @todos = Todos.new
    end

    it 'responds to todo?' do
      expect(@todos).to respond_to(:todo?)
    end

    it 'responds to lines_with_index_for_file for two arguments' do
      expect(@todos).to respond_to(:todo?).with(2).arguments
    end

    it 'returns a bool' do
      expect([true, false]).to include @todos.todo?("", @config)
    end

    it 'returns true if a valid todo is passed' do
      expect(@todos.todo?("#TODO: Something", @config)).to be true
    end

    it 'returns false if a comment that\'s not a todo todo is passed' do
      expect(@todos.todo?("#NODO: Something", @config)).to be(false)
    end

    it 'returns false if a a line doesn\'t start with a comment' do
      expect(@todos.todo?("TODO: Something", @config)).to be(false)
    end

    it 'returns false if a a line is actually code for a hash todo' do
      expect(@todos.todo?("todo: Something", @config)).to be(false)
    end

    it 'returns false if a a line is actually code for an assignment of variable todo' do
      expect(@todos.todo?("todo = @something", @config)).to be(false)
    end

    it 'returns false if a a line is actually code with the word todo in it' do
      expect(@todos.todo?("found_todos[todo].gsub!('', '')", @config)).to be(false)
    end
  end

  describe 'todos_for_file' do

    before(:each) do
      @todos = Todos.new
    end

    it 'responds to todos_for_file' do
      expect(@todos).to respond_to(:todos_for_file)
    end

    it 'responds to todos_for_file for three arguments' do
      expect(@todos).to respond_to(:todos_for_file).with(2).arguments
    end

    it 'returns an array' do
      expect(@todos.todos_for_file("#{@test_dir}/#{@test_file}", @config)).to be_a(Array)
    end

    it 'returns an array of todo objects' do
      files= @todos.todos_for_file("#{@test_dir}/#{@test_file}", @config)
      files.each do |f|
        expect(f).to be_a(Object)
      end
    end

  end

  describe 'all_todos' do

    before(:each) do
      @todos = Todos.new
    end

    it 'responds to all_todos' do
      expect(@todos).to respond_to(:all_todos)
    end

    it 'responds to todos_for_file for two arguments' do
      expect(@todos).to respond_to(:all_todos).with(2).arguments
    end

    it 'returns an array' do
      expect(@todos.all_todos(@test_dir, @config)).to be_a(Array)
    end

    it 'returns an array of todo objects' do
      files= @todos.all_todos(@test_dir, @config)
      files.each do |f|
        expect(f).to be_a(Object)
      end
    end

  end

  describe 'clean_todo' do

    before(:each) do
      @todos = Todos.new
    end

    it 'responds to clean_todo' do
      expect(@todos).to respond_to(:clean_todo)
    end

    it 'responds to clean_todo for two arguments' do
      expect(@todos).to respond_to(:clean_todo).with(2).arguments
    end

    it 'returns a string' do
      expect(@todos.clean_todo("#TODO: FOO BAR", @config)).to be_a(String)
    end

    it 'returns a string without #TODO' do
      expect(@todos.clean_todo("#TODO: Something awesome", @config)).to be_a(String)
    end

  end

end
