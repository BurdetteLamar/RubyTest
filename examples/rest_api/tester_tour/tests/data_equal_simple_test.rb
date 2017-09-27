require_relative '../../base_classes/base_class_for_test'

require_relative '../../../rest_api/data/album'

class DataEqualTest < BaseClassForTest

  def test_data_equal_simple
    prelude do |client, log|
      album_0 = Album.get_first(client)
      album_1 = Album.deep_clone(album_0)
      log.section('These are equal') do
        fail unless Album.equal?(album_0, album_1)
        Album.verdict_equal?(log, 'album equal', album_0, album_1, 'Using Album.verdict_equal?')
      end
      log.section('These are not equal') do
        album_1.id += 1
        fail if Album.equal?(album_0, album_1)
        Album.verdict_equal?(log, 'album not equal', album_0, album_1, 'Using Album.verdict_equal?')
      end
    end
  end

end
