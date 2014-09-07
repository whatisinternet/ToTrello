require 'yaml'

class TotrelloConfig

  def read_config
    config = YAML.load_file("totrello_config.yml")

    @project_name = config['totrello']['project_name']
    @board_name   = config['totrello']['board']
    @default_list = config['totrello']['list']
    @excludes     = config['totrello']['exclude']

    {
     :project_name => @project_name,
     :board_name   => @board_name,
     :default_list => @default_list,
     :excludes     => @excludes
    }
  end

end