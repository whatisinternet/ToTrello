require 'yaml'

class TotrelloConfig
  @project_name
  @board_name
  @default_list
  @excludes
  @todo_types
  @file_types
  @comment_style

  def initialize(directory)
    read_config(directory)
    defaults(directory)
  end

  def build_hash
    {
        :project_name => @project_name,
        :board_name   => @board_name,
        :default_list => @default_list,
        :excludes     => @excludes,
        :todo_types   => @todo_types,
        :file_types   => @file_types,
        :comment_style   => @comment_style
    }
  end

  private
    def read_config(directory)

      totrello_config_file = File.join("#{directory}/", ".totrello.yml")
      trello_yml = Dir.glob(totrello_config_file)[0]

      unless trello_yml.nil?
          puts "Found yml file file: #{trello_yml}"
          config = YAML.load_file(trello_yml )
          config['totrello'].each { |key, value| instance_variable_set("@#{key}", value) }
      end

    end

    def defaults(directory)
      @project_name  ||=  directory.split('/').last
      @board_name    ||= directory.split('/').last
      @default_list  ||= 'To Do'
      @excludes      ||= Array(nil)
      @todo_types    ||= Array(['TODO', '#TODO', '#TODO:', 'TODO:'])
      @file_types    ||= Array(['.rb','.erb'])
      @comment_style ||= Array(['#'])
    end

end