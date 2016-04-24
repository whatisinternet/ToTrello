require 'yaml'

# TrelloConfig
class TrelloConfig
  attr_accessor :project_name, :board_name, :default_list,
                :excludes, :todo_types, :file_types, :comment_style

  def initialize(directory = Dir.pwd.to_s)
    load_config("#{directory}/.totrello.yml")
    default_config(directory)
  end

  def default_config(directory = Dir.pwd.to_s)
    @project_name  ||= directory.split('/').last
    @board_name    ||= directory.split('/').last
    @default_list  ||= 'To Do'
    @excludes      ||= Array(nil)
    @todo_types    ||= Array(['TODO', '#TODO', '#TODO:', 'TODO:'])
    @file_types    ||= Array(['.rb', '.erb'])
    @comment_style ||= Array(['#'])
  end

  def load_config(config_file)
    return if config_file == ''
    config_yaml = YAML.load_file(config_file)

    config_yaml['totrello'].each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end
end
