require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/albums/post_albums'

class PostAlbumsTest < BaseClassForTest

  def test_post_albums
    prelude do |client, log|
      log.section('Test endpoint POST albums') do
        album_to_post = nil
        log.section('Album to post') do
          album_to_post = Album.get_first(client)
          album_to_post.title = 'My album title'
          album_to_post.log(log)
        end
        log.section('POST the album') do
          verdict_id = 'POST album'
          PostAlbums.verdict_call_and_verify_success(client, log, verdict_id, album_to_post)
        end
      end
    end
  end

end