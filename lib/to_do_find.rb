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

  def find_todo(file)
    todo_styles = ['TODO', '#TODO', '#TODO:', 'TODO:']
    @out = []
    code_lines = File.readlines(file)

    return @out unless code_lines.grep('/TODO/' || '/todo/')

    code_lines= code_lines.map.with_index { |x,i| {:todo => x, :location => i + 1}}

    todo_styles.each do |tds|
      @out.concat((code_lines.find_all { |i| is_todo?(i[:todo], (tds))}))
    end

    clean_todos(@out).sort_by { |hsh| hsh[:todo] }
  end

  private
  def clean_todos(todo_array)
    todo_array.each do |found_todos|
      found_todos[:todo].gsub!('TODO:', '')
      found_todos[:todo].gsub!('TODO', '')
      found_todos[:todo].gsub!('#', '')
      found_todos[:todo].chomp!
      found_todos[:todo].lstrip!
    end

  end

  private
  def is_todo?( string, test_string )
    begin
      location = string.split(' ').index test_string
      if location.nil?
        return false
      else
        return true
    end
    rescue
      false
    end

  end

end