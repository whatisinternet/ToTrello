require 'totrello/trello_builder'
require 'totrello/trelloize'
require 'totrello/config'
require 'totrello/todos'

class Trelloize
  attr_accessor :trello, :directory, :config

  def initialize(directory = "#{Dir.pwd}")
    @trello = TrelloBuilder.new
    @directory = directory
    @config = Config.new(directory)
  end

  def description(todo, config)
    return '' if todo.nil?
    out =  "TODO item found by the [ToTrello](https://rubygems.org/gems/totrello) gem\n"
    out += "**Project name:** #{config.project_name}\n"
    out += "**Filename**: #{todo[:file]}\n"
    out += "**Action item**: #{todo[:todo]}\n"
    out += "**Location (at or near) line**: #{todo[:line_number]}\n"
  end

  def find_and_create_cards_from_todos
    todo_finder = Todos.new
    todos = todo_finder.all_todos(@directory, @config)
    board = @trello.find_or_create_board(@config)
    todos.each do |todo|
      description = description(todo, @config)
      @trello.create_card(board, todo[:todo], description, @config.default_list)
    end
  end

end
