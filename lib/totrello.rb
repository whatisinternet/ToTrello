require "totrello/version"
require 'trello_creator'
require 'to_do_find'


module Totrello

  class Trelloize
    @trello
    @directory

    def initialize(directory)
      begin
        @trello = TrelloCreator.new
        @directory = directory
      rescue
        error_data =  "It looks like you're missing some details:\n\n\n"
        error_data += "   You must define TRELLO_DEVELOPER_PUBLIC_KEY & TRELLO_MEMBER_TOKEN\n"
        error_data += "   \nYou can generate the TRELLO_DEVELOPER_PUBLIC_KEY at:\n"
        error_data += "        \nhttps://trello.com/1/appKey/generate\n"
        error_data += "   \nYou can generate the TRELLO_MEMBER_TOKEN at:\n "
        error_data += "\nhttps://trello.com/1/authorize?key=[TRELLO_DEVELOPER_PUBLIC_KEY]&name=ToTrelloGem&expiration=never&response_type=token&scope=read,write\n"
        #raise CustomException.new(error: error_data)
      end

      #find_todo_items
    end

    def find_todo_items
      puts 'Finding your todo items... This should take a minute...'
      todo = ToDoFind.new
      todos = todo.search(@directory)
      puts "Woot! We've got'em"

      puts 'Generating your board'
      board = @trello.find_board(todos[:directory])
      board ||= @trello.create_board(todos[:directory], 'Auto Generated by ToTrello Gem')



      puts 'Taking to Trello, this is the longest part...'
      todos[:todo_list].each do |tdl|
        tdl[:todos].each do |td|
          @trello.create_card(board,td, gen_description(tdl[:file],td),'To Do') unless td == ''
        end
      end
      puts "And you're ready to go!"
    end

    def test_find_todo_items

      todo = ToDoFind.new
      todos = todo.search(@directory)

      todos[:todo_list].each do |tdl|
        tdl[:todos].each do |td|
          puts gen_description(tdl[:file], td)
        end
      end

    end

    def gen_description(file, todo)
      out =  "TODO item found by ToTrello\n"
      out += "Filename: #{file}\n"
      out += "Action item: #{todo[:todo]}\n"
      out += "Location (at or near) line: #{todo[:location]}\n"
    end


  end


end
