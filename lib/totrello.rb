require "totrello/version"
require 'trello_creator'
require 'to_do_find'
require 'totrello_config'


module Totrello

  class Trelloize
    @trello
    @directory
    @config

    def initialize(directory)
      @trello = TrelloCreator.new
      @directory = directory
      totrello_config = TotrelloConfig.new(directory)
      @config = totrello_config.build_hash
    end

    def find_todo_items

      puts 'Generating your board'

      puts "Creating the board: #{@config[:board_name].to_s}"

      board = create_or_gen_board(@config[:board_name].to_s)

      return -1 if board.nil?

      puts "Created or found a board with the ID: #{board.name}"


      create_cards(board)
      puts "And you're ready to go!"

    end

    def create_or_gen_board(board_name)
      board = @trello.find_board(board_name)
      board ||= @trello.create_board(board_name, 'Auto Generated by ToTrello Gem')
    end

    def create_trello_card(board, list, todo, filename)
      description = gen_description(filename,todo, @config[:project_name].to_s)
      card = @trello.create_card(board, todo[:todo], description ,list)
    end

    def gen_description(file, todo, project_name)
      out =  "TODO item found by the [ToTrello](https://rubygems.org/gems/totrello) gem\n"
      out +=  "===========================\n"
      out += "**Project name:** #{project_name}\n"
      out += "**Filename**: #{file}\n"
      out += "**Action item**: #{todo[:todo]}\n"
      out += "**Location (at or near) line**: #{todo[:location]}\n"
    end

    private
      def create_cards(board)


        processes = []
        todos = get_todos

        puts 'Talking to Trello, this is the longest part...'

        todos[:todo_list].each do |tdl|
          tdl[:todos].each do |td|
            unless td == ''
              processes.append(fork {create_trello_card(board, @config[:default_list], td, tdl[:file])})
              #create_trello_card(board, @config[:default_list], td, tdl[:file])

            end
          end
        end

        process_manager(processes)
      end

      def process_manager(processes)
        processes.each {|pro| Process.waitpid(pro)}
      end

      def get_todos
        puts 'Finding your todo items... '
        todo = ToDoFind.new
        todos = todo.search(@directory,
                            Array( @config[:excludes]),
                            Array( @config[:todo_types]),
                            Array( @config[:file_types]),
                            Array( @config[:comment_styles]))
        puts "Woot! We've got'em"
        todos
      end


    end

end
