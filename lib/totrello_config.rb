require 'yaml'

class TotrelloConfig

  def read_config
    config = YAML.load_file("totrello_config.yml")
    @board_name   = config['totrello']['board']
    @default_list = config['totrello']['list']
    @excludes     = config['totrello']['exclude']
    {:board_name => @board_name, :default_list => @default_list, :excludes => @excludes}
  end

end