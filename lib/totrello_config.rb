require 'yaml'

class TotrelloConfig
  @project_name
  @board_name
  @default_list
  @excludes

  def read_config(directory)

    rbfiles = File.join("#{Dir.pwd}/**", ".totrello.yml")
    trello_yml = Dir.glob(rbfiles)[0]

    unless trello_yml.nil?
        config = YAML.load_file(trello_yml )
        config['totrello'].each { |key, value| instance_variable_set("@#{key}", value) }
    end


    defaults(directory)
    {
     :project_name => @project_name,
     :board_name   => @board_name,
     :default_list => @default_list,
     :excludes     => @excludes
    }

  end

  def defaults(directory)
    @project_name ||=  directory.split('/').last
    @board_name   ||= directory.split('/').last
    @default_list ||= 'To Do'
    @excludes     ||= Array(nil)
  end

end