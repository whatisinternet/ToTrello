require 'fileutils'

class ToDoFind

  # This will search a given directory
  #
  def search(directory, excludes_dirs, todo_styles, file_types, comment_styles)

    todos= {directory: directory.split('/').last, :todo_list=>[] }

    files_to_search = exclude_folders(get_folders(directory, file_types), Array(excludes_dirs))

    files_to_search.each do |my_code_file|

      found_todo = find_todo(my_code_file, todo_styles, comment_styles)

      if found_todo
        todos[:todo_list].append(
                                {:file=> my_code_file.gsub(directory,''),
                                 :todos => found_todo}
        )
      end

    end
    todos
  end

  def get_todos(files_to_search, found_todo)


  end

  def get_folders(directory, file_types)    
    directory ||= Dir.pwd
    files = get_internal_folders(directory, file_types)
  end

  def exclude_folders(file_array, excludes_array)
    excludes_array.each do |excludes_dir|
      file_array.reject! { |i|  i.include? excludes_dir }
    end
    file_array
  end

  def find_todo(file, todo_styles, comment_styles)
    @out = []

    todo_styles.each do |tds|
      @out.concat((get_code(file).find_all { |i| is_todo?(i[:todo], (tds))}))
    end

    clean_todos(@out, todo_styles, comment_styles).sort_by { |hsh| hsh[:todo] }
  end

  private

    def get_internal_folders(directory, file_types)
      files = []
      file_types.each do |ft|
        file = File.join("#{directory}/**", "*#{ft.to_s}")
        files.concat(Dir.glob(file))
      end
      files
    end

    def get_code(file)
        code_lines = File.readlines(file)
        code_lines.map.with_index { |x,i| {:todo => x, :location => i + 1}}
    end

    def clean_todos(todo_array, todo_styles, comment_styles)
      todo_array.each do |found_todos|
        todo_styles.each do |tds|
          found_todos[:todo].gsub!(tds,'')
        end
        comment_styles.each do |cms|
          found_todos[:todo].gsub!(cms,'')
        end
        found_todos[:todo].gsub!('#','')
        found_todos[:todo].gsub!(':','')
        found_todos[:todo].chomp!
        found_todos[:todo].lstrip!
      end

    end

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