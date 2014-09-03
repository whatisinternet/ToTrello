require 'trello'

class TrelloCreator
  def initialize
    Trello.configure do |config|
      config.developer_public_key = TRELLO_DEVELOPER_PUBLIC_KEY
      config.member_token  =  TRELLO_MEMBER_TOKEN
    end
  end

  def create_card(board, name, description, list_name)
    unless card_exists?(board, list_name, name[:todo])
      card = Trello::Card.create(name: name[:todo], list_id: self.find_list(board, list_name), description: description)
      card.save
    end
  end

  def find_cards(board,list)
    list = Trello::List.new 'idBoard' => board,
                            'id'      => list
    list.cards
  end

  def create_board(board_name, description)
    Trello::Board.create(name: board_name, description: description)
  end

  def find_board(name)
    out = ''
    Trello::Board.all.each do |board|
      if board.name.upcase == name.upcase
        out = board.id
      end
    end
    Trello::Board.find(out)
  end

  def find_list(board, list_name)
    board.lists.find { |list| list.name == list_name }.id
  end

  def card_exists?(board, list_name, card_name)
    out = false
    self.find_cards(board,self.find_list(board, list_name)).each do |card|
      if card.name.include? card_name
        out = true
      end
    end
    out
  end

end