require 'trello'

class TrelloCreator
  def initialize
    Trello.configure do |config|
      config.developer_public_key = TRELLO_DEVELOPER_PUBLIC_KEY
      config.member_token  =  TRELLO_MEMBER_TOKEN
    end
  end

  def create_card(board, name, description, list_name)
    list_names = ['To Do', 'Doing', 'Done']
    unless card_exists?(board, list_names, name)
      card = Trello::Card.create(name: name, list_id: self.find_list(board, list_name), desc: description)
      card.save

      #puts card.desc
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
    if out == ''
      nil
    else
      Trello::Board.find(out)
    end
  end

  def find_list(board, list_name)
    board.lists.find { |list| list.name == list_name }.id
  end

  def card_exists?(board, list_names, card_name)
    out = false
    list_names.each do |list_name|
      self.find_cards(board,self.find_list(board, list_name)).each do |card|
        return true if card_name.nil?
        if card.name.include? card_name
          out = true
        end
      end
    end

    out
  end

end