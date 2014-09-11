require 'totrello'
require 'digest/sha1'

describe 'ToDoFind' do

  describe 'find_todo_items' do
    it 'returns a hash of todo items from a directory'do
      todo = ToDoFind.new
      todos = todo.search("#{Dir.pwd}/test/test_data",
                          nil,
                          Array(['TODO', '#TODO', '#TODO:', 'TODO:']),
                          Array(['.rb','.erb']),
                          Array(['#']))
      expected = {:directory => "test_data",
                  :todo_list => [{:file => "/testing.rb",
                                  :todos => [{:todo => "test1", :location => 1},
                                             {:todo => "test2", :location => 2},
                                             {:todo => "test3", :location => 3},
                                             {:todo => "test4}", :location => 4},
                                             {:todo => "test5", :location => 5},
                                             {:todo => "test6", :location => 6}]}]}
      expect(todos).to include(expected)
    end

  end

  describe 'formatted_data' do
    it "Should have a string for the todo and an Int for the locaion" do
      todo = ToDoFind.new
      todos = todo.search("#{Dir.pwd}/test/test_data",
                          nil,
                          Array(['TODO', '#TODO', '#TODO:', 'TODO:']),
                          Array(['.rb','.erb']),
                          Array(['#']))

      todos[:todo_list].each do |tdl|
        tdl[:todos].each do |td|
          expect(td[:todo]).to be_a_kind_of(String)
          expect(td[:location]).to be_a_kind_of(Integer)
        end
      end

    end

  end

  describe 'get_folders' do
    it "Should return an array of files and folders" do
      todo = ToDoFind.new
      files = todo.get_folders("#{Dir.pwd}/test/test_data",Array(['.rb','.erb']))
      expect(files).to be_a(Array)
    end

  end

  describe 'exclude_folders' do
    it "Should return an array an empty array" do
      todo = ToDoFind.new
      files =todo.get_folders("#{Dir.pwd}/test/test_data",Array(['.rb','.erb']))
      files = todo.exclude_folders(files, Array(['test']))
      expect(files).to be_a(Array)
      expect(files).to match_array([])
    end

  end

end