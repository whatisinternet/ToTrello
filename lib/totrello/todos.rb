class Todos

  def load_directories(root_directory = "#{Dir.pwd}", config)
     Dir.glob("#{root_directory}/**/*").select do |f|
      File.directory?(f) && !config.excludes.includes?(f)
    end
  end

  def load_files(root_directory = "#{Dir.pwd}", config)
    Dir.glob("#{root_directory}/*").select do |f|
      split_file_name = f.split('.')
      File.file?(f) &&
        config.file_types.include?(split_file_name.last)
    end
  end

  def todos_for_file(directory, file, config)
    lines_with_indexes = lines_with_index_for_file(directory, file)
    lines_with_indexes.reduce([]) do |todos, line|
      return todos unless todo?(line[:line], config)
      todos.push({
          todo: line[:line],
          line_number: line[:index],
          file: "#{directory}/#{file}"
      })
    end
  end

  def lines_with_index_for_file(directory, file)
    lines = File.readlines "#{directory}/#{file}"
    lines.map.with_index do |line, idx|
      {line: line, index: idx}
    end
  end

  def todo?(line, config)
    return false if line.empty?
    todo_types = config.todo_types
    todo_types.any? do |todo_type|
      return false if line.split(' ').index(todo_type).nil?
      true
    end
  end

end
