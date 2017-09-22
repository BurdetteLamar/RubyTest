require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/albums/post_albums'

class PostAlbumsTest < BaseClassForTest

  def test_post_albums

    prelude do |client, log|

      log.section('Test endpoint POST albums') do

        album_to_post = nil
        log.section('Fetch an album to POST') do
          album_to_post = Album.get_first(client)
          log.section('Album fetched') do
            album_to_post.log(log)
          end
        end

        log.section('POST the album') do
          verdict_id = 'POST album'
          album_to_post.title = 'My Title'
          PostAlbums.verdict_call_and_verify_success(client, log, verdict_id, album_to_post)
        end

      end

    end
  end
end