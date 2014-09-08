require 'fileutils'

class ToDoFind

  # This will search a given directory
  #
  def search(directory, excludes_dirs)
    files_to_search = []

    directory ||= Dir.pwd

    todos= {directory: directory.split('/').last, :todo_list=>[] }

    files_to_search = exclude_folders(get_folders(directory), Array(excludes_dirs))


    files_to_search.each do |my_text_file|

      found_todo = find_todo(my_text_file)


      if found_todo
        todos[:todo_list].append(
                                {:file=> my_text_file.gsub(directory,''),
                                 :todos => found_todo}
        )
      end

    end
    todos
  end

  def get_folders(directory)
    directory ||= Dir.pwd
    rbfiles = File.join("#{directory}/**", "*.*rb")
    Dir.glob(rbfiles)
  end

  def exclude_folders(file_array, excludes_array)
    excludes_array.each do |excludes_dir|
      file_array.reject! { |i|  i.include? excludes_dir }
    end
    file_array
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