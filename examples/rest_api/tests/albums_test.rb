require_relative 'base_class_for_test'

require_relative '../endpoints/albums/get_albums'

require_relative '../../../lib/log'

class AlbumsTest < BaseClassForTest

  def test_get_albums

    prelude do |client, log|

      albums = GetAlbums.call(client)
      album = albums.first
      album.verdict_valid?(log, 'album')

    end

  end

end