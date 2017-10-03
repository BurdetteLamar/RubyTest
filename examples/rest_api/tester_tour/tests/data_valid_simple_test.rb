require_relative '../../base_classes/base_class_for_test'

require_relative '../../../rest_api/data/album'

class DataValidSimpleTest < BaseClassForTest

  def test_data_valid_simple
    prelude do |client, log|
      log.section('This is valid') do
        album = Album.get_first(client)
        album.verdict_valid?(log, 'album valid')
      end
      log.section('This is not valid') do
        album = Album.new(
            :id => Album.id_invalid,
            :userId => Album.user_id_invalid,
            :title => Album.title_invalid,
        )
        album.verdict_valid?(log, 'album not valid')
      end
    end
  end

end
