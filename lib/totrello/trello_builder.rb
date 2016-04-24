require 'trello'

class TrelloBuilder

  def initialize
    Trello.configure do |config|
      config.developer_public_key = TRELLO_DEVELOPER_PUBLIC_KEY
      config.member_token = TRELLO_MEMBER_TOKEN
    end
  end

  def cards(board, list)
    Trello::List.new('idBoard' => board, 'id' => list).cards
  end

  def create_board(config)
    Trello::Board.create(name: config.board_name, description: "A Trello board")
  end

  def create_card(board, card_name, description, list_name)
    list_names = ['To Do', 'Doing', 'Done']
    return if card_exists?(board, list_names, card_name)
    list = find_list(board, list_name)
    card = Trello::Card.create(name: card_name,
                               list_id: list,
                               desc: description)
    card.save
  end

  def card_exists?(board, list_names, card_name)
    list_names.any? do |list_name|
      list = find_list(board, list_name)
      all_cards = cards(board, list)
      all_cards.any? do |card|
        card.name.include? card_name
      end
    end
  end

  def find_board(config)
    board_name = config.board_name
    trello_board = Trello::Board.all.find do |board|
      board.name.upcase == board_name.upcase && !board.closed
    end
    return nil if trello_board.nil?
    Trello::Board.find(trello_board.id)
  end

  def find_list(board, list_name)
    return unless board
    board.lists.find { |list| list.name == list_name }.id
  end

  def find_or_create_board(config)
    board = find_board(config)
    board = create_board(config) if board.nil?
    board
  end

end

