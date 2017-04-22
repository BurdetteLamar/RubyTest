require_relative 'base_class_for_test'

require_relative '../endpoints/albums/get_albums'

require_relative '../../../lib/log/log'

class AlbumsTest < BaseClassForTest

  def test_get_albums

    prelude do |client, log|

      GetAlbums.verdict_call_and_verify_success(client, log, 'get albums')

    end

  end

end