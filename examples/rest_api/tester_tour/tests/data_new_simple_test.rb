require_relative '../../base_classes/base_class_for_test'

require_relative '../../../rest_api/data/album'
require_relative '../../../rest_api/data/user'

class DataNewTest < BaseClassForTest

  def test_data_new_simple
    prelude do |_, log|
      log.section('Create and log an instance of Album') do
        album = Album.new(
            :id => nil,
            :userId => 1,
            :title => 'My album title',
        )
        log.section('Created album') do
          album.log(log)
        end
      end
    end
  end

end
