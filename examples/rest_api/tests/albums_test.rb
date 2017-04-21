require_relative 'base_class_for_test'

require_relative '../endpoints/albums/get_albums'

require_relative '../../../lib/log'

class AlbumsTest < BaseClassForTest

  def test_get_albums

    prelude do |client, log|

      albums = GetAlbums.call(client)
      album = albums.first
      album.verdict_valid?(log, 'album')
      # if log.verdict_assert_instance_of?('album class', Album, album, 'First object is an Album')
      #   log.verdict_assert_operator?('positive id', 0, :<, album.id, 'Album id is positive')
      #   log.verdict_assert_operator?('positive user-id', 0, :<, album.id, 'Album user-id is positive')
      #   if log.verdict_assert_instance_of?('title class', String, album.title, 'Album title is a String')
      #     log.verdict_refute_empty?('non-empty title', album.title, 'Album title is not empty')
      #   end
      # end

    end

  end

end