require 'rspec'
require 'totrello_config'

describe 'defaults' do

  it 'should produce a hash of the defaulted settings file' do


    sample_config = TotrelloConfig.new("#{Dir.pwd}/test/test_data/noymlfile")
    test_settings =     {
        :project_name => 'noymlfile',
        :board_name   => 'noymlfile',
        :default_list => 'To Do',
        :excludes     => Array(nil)
    }
    expect(sample_config.build_hash).to include(test_settings)




  end
end