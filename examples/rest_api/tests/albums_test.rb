require_relative 'base_class_for_test'

require_relative '../endpoints/albums/get_albums'

class AlbumsTest < BaseClassForTest

  def test_get_albums

    prelude do |client, log|

      p GetAlbums.call(client)

    end

  end

end