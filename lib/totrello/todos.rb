class Todos

  def all_todos(root_directory = "#{Dir.pwd}", config)
    files = load_files(root_directory, config)
    files.map {|f| todos_for_file(f, config) }.flatten
  end

  def load_files(root_directory = "#{Dir.pwd}", config)
    Dir.glob("#{root_directory}/**/*").select do |f|
      next if File.directory?(f) || config.excludes.include?(f)
      split_file_name = f.split('.')
      File.file?(f) &&
        config.file_types.include?(".#{split_file_name.last}")
    end
  end

  def todos_for_file(file, config)
    lines_with_indexes = lines_with_index_for_file(file)
    lines_with_indexes.reduce([]) do |todos, line|
      if todo?(line[:line], config)
        cleaned_todo = clean_todo(line[:line], config)
        unless cleaned_todo.nil?
          todos.push({
              todo: cleaned_todo,
              line_number: line[:index],
              file: "#{file}"
          })
        end
      end
      todos
    end
  end

  def lines_with_index_for_file(file)
    lines = File.readlines "#{file}"
    lines.map.with_index do |line, idx|
      {line: line, index: idx}
    end
  end

  def todo?(line, config)
    return false if line.empty?
    todo_types = config.todo_types
    todo_types.any? do |todo_type|
      return false if line.index(todo_type).nil?
      return false unless config.comment_style.any? { |cs| line.strip.start_with?(cs)}
      true
    end
  end

  def clean_todo(todo, config)
    config.todo_types.each do |style|
      todo.gsub!(style, '')
    end
    config.comment_style.each do |style|
      todo.gsub!(style, '')
    end
    todo.gsub!('#','')
    todo.gsub!(':','')
    todo.chomp!
    todo.lstrip!
  end


end
