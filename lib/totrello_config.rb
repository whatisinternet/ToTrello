require 'yaml'

class TotrelloConfig

  def read_config(directory)

    begin

      rbfiles = File.join("#{Dir.pwd}/**", ".totrello.yml")
      config = YAML.load_file( Dir.glob(rbfiles)[0])

      puts 'Found a .totrello.yml file!'

      project_name = config['totrello']['project_name']
      board_name   = config['totrello']['board']
      default_list = config['totrello']['list']
      excludes     = Array(config['totrello']['exclude'])

    rescue

      puts 'No .yml file found or your yml file is corrupt. Making assumptions.'

      project_name =  directory.split('/').last
      board_name   = directory.split('/').last
      default_list = 'To Do'
      excludes     = Array(nil)

    end

    {
     :project_name => project_name,
     :board_name   => board_name,
     :default_list => default_list,
     :excludes     => excludes
    }

  end

end