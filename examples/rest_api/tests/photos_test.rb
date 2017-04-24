require_relative 'base_class_for_test'

require_relative '../endpoints/photos/get_photos'
require_relative '../endpoints/photos/get_photos_id'

require_relative '../data/photo'
require_relative '../../../lib/log/log'

class PhotosTest < BaseClassForTest

  def test_get_photos

    prelude do |client, log|

      GetPhotos.verdict_call_and_verify_success(client, log, 'get photos')

    end

  end

  def test_get_photos_id

    prelude do |client, log|

      photo_to_fetch = Photo.get_first(client)
      GetPhotosId.verdict_call_and_verify_success(client, log, 'get photo', photo_to_fetch)
    end
  end

end
