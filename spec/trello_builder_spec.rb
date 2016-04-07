require 'spec_helper'
require 'totrello/trello_builder'
require 'totrello/config'
require 'digest/sha1'

describe TrelloBuilder do

  before(:all) do
    @test_dir = "#{Dir.pwd}/spec/fixtures"
    @test_file = "fixture.rb"
    @config = Config.new
  end

  after(:all) do
    @trello = TrelloBuilder.new
    board = @trello.find_board(@config)
    board.closed = true
    board.save
  end

  describe 'find_board' do

    before(:each) do
      @trello = TrelloBuilder.new
    end

    it 'responds to find_board' do
      expect(@trello).to respond_to(:find_board)
    end

    it 'responds to find_board with config' do
      expect(@trello).to respond_to(:find_board).with(1).argument
    end

    it 'responds with a board if the board exists' do
      VCR.use_cassette 'find_board' do
        expect(@trello.find_board(@config)).not_to be_nil
      end
    end

  end

  describe 'create_board' do
    before(:each) do
      @trello = TrelloBuilder.new
    end

    after(:each) do
      board = @trello.find_board(@config)
      board.update_fields({closed: true})
      board.save
    end

    it 'responds to create_board' do
      expect(@trello).to respond_to(:create_board)
    end

    it 'responds to create_board with config' do
      expect(@trello).to respond_to(:create_board).with(1).argument
    end

    it 'creates a board' do
      VCR.use_cassette 'create_board' do
        expect(@trello.create_board(@config)).to be_a(Trello::Board)
      end
    end

  end

  describe 'find_or_create_board' do
    before(:each) do
      @trello = TrelloBuilder.new
    end

    it 'responds to find_or_create_board' do
      expect(@trello).to respond_to(:find_or_create_board)
    end

    it 'responds to find_or_create_board with config' do
      expect(@trello).to respond_to(:find_or_create_board).with(1).argument
    end

    it 'finds or creates a board' do
      VCR.use_cassette 'finds_or_creates_a_board' do
        expect(@trello.find_or_create_board(@config)).to be_a(Trello::Board)
      end
    end

  end

  describe 'find_list' do
    before(:each) do
      @trello = TrelloBuilder.new
      @board = @trello.find_board(@config)
      @list_name = 'To Do'
    end

    it 'responds to find_list' do
      expect(@trello).to respond_to(:find_list)
    end

    it 'responds to find_list with board and list_name' do
      expect(@trello).to respond_to(:find_list).with(2).arguments
    end

    it 'returns the id of the list' do
      VCR.use_cassette 'gets list id' do
        expect(@trello.find_list(@board, @list_name)).to be_a(String)
      end
    end

  end

  describe 'cards' do
    before(:each) do
      @trello = TrelloBuilder.new
      @board = @trello.find_board(@config)
      @list_name = 'To Do'
      @list_id = @trello.find_list(@board, @list_name)
    end

    it 'responds to cards' do
      expect(@trello).to respond_to(:cards)
    end

    it 'responds to cards with board and list_id' do
      expect(@trello).to respond_to(:cards).with(2).arguments
    end

    it 'returns a collection of cards' do
      VCR.use_cassette 'list of cards' do
        expect(@trello.cards(@board, @list_id)).to be_a(Array)
      end
    end

  end

  describe 'card_exists?' do
    before(:each) do
      @trello = TrelloBuilder.new
      @board = @trello.find_board(@config)
      @list_name = 'To Do'
      @list_id = @trello.find_list(@board, @list_name)
    end

    it 'responds to card_exists?' do
      expect(@trello).to respond_to(:card_exists?)
    end

    it 'responds to card_exists? with board, list_names and card_name' do
      expect(@trello).to respond_to(:card_exists?).with(3).arguments
    end

    it 'returns false if the card doesn\'t exist' do
      VCR.use_cassette 'doesn\'t find a card' do
        expect(@trello.card_exists?(@board, ['To Do'], srand.to_s)).to be_falsey
      end
    end

  end

  describe 'create_card' do
    before(:each) do
      @trello = TrelloBuilder.new
      @board = @trello.find_board(@config)
      @list_name = 'To Do'
      @list_id = @trello.find_list(@board, @list_name)
      @card_name = (Digest::SHA1.hexdigest Time.now.to_s)
    end

    it 'responds to create_card' do
      expect(@trello).to respond_to(:create_card)
    end

    it 'responds to create_card with a board, name, description, and list' do
      expect(@trello).to respond_to(:create_card).with(4).arguments
    end

    it 'returns a string of json if the card is created' do
      VCR.use_cassette 'card created' do
        expect(@trello.create_card(
          @board, @card_name, 'bar', @list_name
        )).to be_a(String)
      end
    end

  end

end
