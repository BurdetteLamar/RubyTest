require_relative '../../base_classes/base_class_for_test'

require_relative '../../../rest_api/data/album'

class DataEqualTest < BaseClassForTest

  def test_data_equal_simple
    prelude do |client, log|
      album = Album.get_first(client)
      Album.equal?(album, album)
      Album.verdict_equal?(log, 'album equal', album, album, 'Using Album.verdict_equal?')
    end
  end

end
