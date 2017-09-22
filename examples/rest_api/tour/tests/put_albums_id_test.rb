require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/albums/put_albums_id'

class PutAlbumsIdTest < BaseClassForTest

  def test_put_albums_id

    prelude do |client, log|

      log.section('Test endpoint PUT albums/id') do

        album_to_put = nil
        log.section('Fetch an album to PUT') do
          album_to_put = Album.get_first(client)
          log.section('Album fetched') do
            album_to_put.log(log)
          end
        end

        log.section('PUT the album') do
          verdict_id = 'PUT album'
          album_to_put.title = 'My New Title'
          PutAlbumsId.verdict_call_and_verify_success(client, log, verdict_id, album_to_put)
        end

      end

    end
  end
end