require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/albums/delete_albums_id'

class DeleteAlbumsIdTest < BaseClassForTest

  def test_delete_albums_id
    prelude do |client, log|
      log.section('Test endpoint DELETE albums/id') do
        album_to_delete = nil
        log.section('Fetch an album to DELETE') do
          album_to_delete = Album.get_first(client)
          log.section('Album fetched') do
            album_to_delete.log(log)
          end
        end
        log.section('DELETE the album') do
          verdict_id = 'DELETE album'
          DeleteAlbumsId.verdict_call_and_verify_success(client, log, verdict_id, album_to_delete)
        end
      end
    end
  end

end