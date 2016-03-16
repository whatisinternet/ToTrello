require 'spec_helper'
require 'config'

describe 'Config' do

  before(:all) do
    @attrs = %w(project_name board_name default_list excludes todo_types file_types comment_style)
  end

  describe 'instance vars' do

    before(:each) do
      @config = Config.new
    end

    it 'defines attrs' do
      @attrs.each do |att|
        expect(@config).to respond_to(att.to_sym)
      end
    end


  end

  describe 'initialize' do

    it 'responds to new' do
      expect(Config).to respond_to(:new)
    end

    it 'responds to new with an argument' do
      expect(Config).to respond_to(:new).with(1).argument
    end

    it 'builds a hash of settings' do
      asserted_config = Config.new("#{Dir.pwd}/spec/fixtures")
      expected_config = {
        project_name: 'ToTrello',
        board_name: 'ToTrello',
        default_list: 'To Do',
        todo_types: ['TODO', '#TODO', '#TODO:', 'TODO:', 'FIXME', '#FIXME', '#FIXME:', 'FIXME:'],
        comment_style: ['#','//'],
        file_types: ['.rb','.yml'],
        excludes: [ 'pkg/', 'bin/']
      }

      @attrs.each do |at|
        expect(asserted_config.send(at.to_sym)).to eq(expected_config[at.to_sym])
      end

    end

  end

  describe 'load_defaults' do
    before(:each) do
      @config = Config.new
    end

    it 'has a default config' do

      expect(@config).to respond_to(:default_config)

    end

    it 'has a default config that accepts a directory' do

      expect(@config).to respond_to(:default_config).with(1).argument

    end

    it 'loads the default config into the attr_accessors' do
      @config.default_config

      @attrs.each do |at|
        expect(@config.send(at.to_sym)).not_to be_nil
      end
    end

  end

  describe 'load_config' do

    before(:each) do
      @config = Config.new
    end

    it 'has a config loader' do

      expect(@config).to respond_to(:load_config)

    end

    it 'has a config loader that accepts a file' do

      expect(@config).to respond_to(:load_config).with(1).argument

    end

    it 'retuns nil if no file is specified' do
      expect(@config.load_config('')).to be_nil
    end

    it 'does not return nil if a file is specified' do
      expect(@config.load_config("#{Dir.pwd}/spec/fixtures/.totrello.yml")).not_to be_nil
    end

    it 'loads the config into the attr_accessors' do
      @config.load_config("#{Dir.pwd}/spec/fixtures/.totrello.yml")

      @attrs.each do |at|
        expect(@config.send(at.to_sym)).not_to be_nil
      end
    end

  end

end
