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

  private
  def find_todo(file)
    @out = []
    histories = File.readlines(file)
    line_num = 0
    histories.each do |hist|
      line_num += 1
      todo_location = is_todo?( hist, 'TODO' )
      todo_location ||= is_todo?( hist, 'TODO:' )
      todo_location ||= is_todo?( hist, ' TODO:' )
      todo_location ||= is_todo?( hist, ' TODO' )
      todo_location ||= is_todo?( hist, '#TODO:' )
      todo_location ||= is_todo?( hist, '#TODO' )
      if todo_location.nil?  #TODO What is this?

        unless hist.start_with? ('#TODO' || '# TODO' || '#TODO:' || '# TODO:')
          todo_and_location = {:todo => hist.split('TODO')[1],
                               :location => line_num}
          @out.append(todo_and_location)
        end


      else
        temp_string_array = hist.split(' ')
        todo = hist.split(' ')[(todo_location + 1)..((temp_string_array.length) - 1)].join(' ')
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
      string.split(' ').index test_string
    rescue
      return nil
    end

  end

end