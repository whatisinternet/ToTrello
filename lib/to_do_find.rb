require 'fileutils'

class ToDoFind

  # This will search a given directory
  #
  def search(directory)

    dir = directory
    dir ||= Dir.pwd

    todos= {directory: dir.split('/').last, :todo_list=>[] }

    rbfiles = File.join("#{dir}/**", "*.*rb")

    Dir.glob(rbfiles) do |my_text_file|

      found_todo = find_todo(my_text_file)


      if found_todo
        todos[:todo_list].append(
                                {:file=> my_text_file.gsub(dir,''),
                                 :todos => found_todo}
        )
      end

    end
    todos
  end

  #TODO: Kind of important but this doesn't seem to be working...
  private
  def find_todo(file)
    @out = []
    code_lines = File.readlines(file)
    return @out unless code_lines.grep('/TODO/' || '/todo/')

    line_num = 0
    code_lines.each do |code_line|
      line_num += 1
      todo_location = is_todo?( code_line, 'TODO' )
      todo_location ||= is_todo?( code_line, 'TODO:' )
      todo_location ||= is_todo?( code_line, ' TODO:' )
      todo_location ||= is_todo?( code_line, ' TODO' )
      todo_location ||= is_todo?( code_line, '#TODO:' )
      todo_location ||= is_todo?( code_line, '#TODO' )
      unless todo_location.nil?
        temp_string_array = code_line.split(' ')
        todo = code_line.split(' ')[(todo_location + 1)..((temp_string_array.length) - 1)].join(' ')
        puts "Found! #{todo}"
        todo_and_location = {:todo => todo,
                             :location => line_num}
        @out.append(todo_and_location)
      end



    end
    @out
  end

  private
  def is_todo?( string, test_string )
    begin
      string.downcase.split(' ').index test_string.downcase
    rescue
      return nil
    end

  end

end