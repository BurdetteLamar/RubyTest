require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/albums/get_albums_id'

class GetAlbumsIdTest < BaseClassForTest

  def test_get_albums_id

    prelude do |client, log|

      log.section('Test endpoint GET albums/id') do

        album_to_get = nil
        log.section('Fetch an album to GET') do
          album_to_get = Album.get_first(client)
          log.section('Album fetched') do
            album_to_get.log(log)
          end
        end

        log.section('GET the album') do
          verdict_id = 'GET album'
          GetAlbumsId.verdict_call_and_verify_success(client, log, verdict_id, album_to_get)
        end

      end

    end
  end
end