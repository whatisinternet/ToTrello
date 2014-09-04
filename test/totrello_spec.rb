require 'totrello'
require 'digest/sha1'


TRELLO_DEVELOPER_PUBLIC_KEY = ENV['TRELLO_DEVELOPER_PUBLIC_KEY']
TRELLO_MEMBER_TOKEN = ENV['TRELLO_MEMBER_TOKEN']

describe 'totrello#initialize' do

  it "should return a trello and directory" do

    t = Totrello::Trelloize.new("#{Dir.pwd}/test/test_data")
    expect(t).to be_an_instance_of(Totrello::Trelloize)
    #expect(@directory).to be_a_kind_of(String)

  end

end

describe 'totrello#create_or_gen_board' do
  it "should return a board" do
    directory = "#{Dir.pwd}/test/test_data"
    t = Totrello::Trelloize.new(directory)
    board = t.create_or_gen_board(directory.split('/').last)
    expect(board.name.downcase).to  eq(directory.split('/').last.downcase)
  end

end

describe 'totrello#create_card' do
  it "should return a card" do
    directory = "#{Dir.pwd}/test/test_data"
    t = Totrello::Trelloize.new(directory)
    board = t.create_or_gen_board(directory.split('/').last)
    card_name = Digest::SHA1.hexdigest Time.now.to_s
    card = t.create_trello_card(board, 'To Do', {:todo => card_name, :location => card_name.reverse }, directory.split('/').last)
    expect(card).to include(card_name)
  end

end

describe '#find_todo_items' do
  it 'returns a hash of todo items from a directory'do
    todo = ToDoFind.new
    todos = todo.search("#{Dir.pwd}/test/test_data")
    expected = {:directory => "test_data", :todo_list => [{:file => "/testing.rb", :todos => [{:todo => "test1", :location => 1}, {:todo => "test2", :location => 2}, {:todo => "test3", :location => 3}, {:todo => "test4}", :location => 4}, {:todo => "test5", :location => 5}, {:todo => "test6", :location => 6}]}]}
    expect(todos).to include(expected)
  end

end

describe 'formatted_data' do
  it "Should have a string for the todo and an Int for the locaion" do
    todo = ToDoFind.new
    todos = todo.search("#{Dir.pwd}/test/test_data")

    todos[:todo_list].each do |tdl|
      tdl[:todos].each do |td|
        expect(td[:todo]).to be_a_kind_of(String)
        expect(td[:location]).to be_a_kind_of(Integer)
      end
    end

  end

end



