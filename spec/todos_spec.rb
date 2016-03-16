require 'spec_helper'
require 'totrello/todos'
require 'totrello/config'

describe Todos do
  before(:all) do
    @test_dir = "#{Dir.pwd}/spec/fixtures"
    @test_file = "fixture.rb"
    @config = Config.new
  end

  describe 'load_directories' do

    before(:each) do
      @todos = Todos.new
    end

    it 'responds to load_directories' do
      expect(@todos).to respond_to(:load_directories)
    end

    it 'responds to load_directories with a directory path' do
      expect(@todos).to respond_to(:load_directories).with(2).arguments
    end

    it 'returns an array of directory strings' do
      expect(@todos.load_directories(@test_dir, @config)).to be_a(Array)
    end

    it 'each item must be a string' do
      directories = @todos.load_directories(@test_dir, @config)
      directories.each do |directory|
        expect(directory).to be_a(String)
      end
    end

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

    it 'responds to lines_with_index_for_file for two arguments' do
      expect(@todos).to respond_to(:lines_with_index_for_file).with(2).arguments
    end

    it 'returns an array' do
      expect(@todos.lines_with_index_for_file(@test_dir, @test_file)).to be_a(Array)
    end

    it 'returns an array of todo objects' do
      files= @todos.lines_with_index_for_file(@test_dir, @test_file)
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
      expect([true, false]).to include @todos.todo?("#TODO: Something", @config)
    end

    it 'returns false if an invalid todo is passed' do
      expect([true, false]).to include @todos.todo?("#NODO: Something", @config)
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
      expect(@todos).to respond_to(:todos_for_file).with(3).arguments
    end

    it 'returns an array' do
      expect(@todos.todos_for_file(@test_dir, @test_file, @config)).to be_a(Array)
    end

    it 'returns an array of todo objects' do
      files= @todos.todos_for_file(@test_dir, @test_file, @config)
      files.each do |f|
        expect(f).to be_a(Object)
      end
    end

  end

end
