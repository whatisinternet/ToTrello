#TODO: test1
# TODO: test2
#  TODO test3
# TODO: test4}
  #TODO test5
 #TODO: test6
todo
todo.test
TODO.tst #sdfasdfasdf
def clean_todos(todo_array)
  todo_array.each do |found_todos|
    found_todos[:todo].gsub!('TODO:', '')
    found_todos[:todo].gsub!('TODO', '')
    found_todos[:todo].gsub!('#', '')
    found_todos[:todo].chomp!
    found_todos[:todo].lstrip!
  end

end