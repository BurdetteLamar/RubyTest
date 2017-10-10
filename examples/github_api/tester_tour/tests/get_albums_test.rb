require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/albums/get_albums'

class GetAlbumsTest < BaseClassForTest

  def test_get_albums
    prelude do |client, log|
      log.section('Test endpoint GET albums') do
        log.section('GET albums') do
          verdict_id = 'GET albums'
          GetAlbums.verdict_call_and_verify_success(client, log, verdict_id)
        end
      end
    end
  end

end