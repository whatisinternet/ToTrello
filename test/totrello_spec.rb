require 'totrello'
require 'digest/sha1'

describe 'Totrello' do

  describe 'initialize' do

    it "should return a trello and directory" do

      t = Totrello::Trelloize.new("#{Dir.pwd}/test/test_data")
      expect(t).to be_an_instance_of(Totrello::Trelloize)

    end

  end

  describe 'create_or_gen_board' do

    it "should return a board" do
      directory = "#{Dir.pwd}/test/test_data"

      t = Totrello::Trelloize.new(directory)
      board = t.create_or_gen_board(directory.split('/').last)

      expect(board.name.downcase).to  eq(directory.split('/').last.downcase)

    end

  end

  describe 'create_card' do

    it "should return a card" do

      directory = "#{Dir.pwd}/test/test_data"

      t = Totrello::Trelloize.new(directory)
      board = t.create_or_gen_board(directory.split('/').last)

      card_name = Digest::SHA1.hexdigest Time.now.to_s

      card = t.create_trello_card(board, 'To Do', {:todo => card_name, :location => card_name.reverse }, directory.split('/').last)

      expect(card).to include(card_name)

    end

  end

end

