require_relative 'base_class_for_test'

require_relative '../endpoints/albums/get_albums'
require_relative '../endpoints/albums/get_albums_id'

require_relative '../data/album'
require_relative '../../../lib/log/log'

class AlbumsTest < BaseClassForTest

  def test_get_albums

    prelude do |client, log|

      GetAlbums.verdict_call_and_verify_success(client, log, 'get albums')

    end

  end

  def test_get_albums_id

    prelude do |client, log|

      album_to_fetch = Album.get_first(client)
      GetAlbumsId.verdict_call_and_verify_success(client, log, 'get album', album_to_fetch)
    end
  end

end
