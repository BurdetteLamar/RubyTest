require_relative 'base_class_for_test'

require_relative '../endpoints/photos/delete_photos_id'
require_relative '../endpoints/photos/get_photos'
require_relative '../endpoints/photos/get_photos_id'
require_relative '../endpoints/photos/post_photos'
require_relative '../endpoints/photos/put_photos_id'

require_relative '../data/photo'
require_relative '../../../lib/log/log'

class PhotosTest < BaseClassForTest

  def test_delete_photos_id

    prelude do |client, log|
      log.section('Test DeletePhotos') do
        photo_to_delete = nil
        log.section('Get a photo to delete') do
          photo_to_delete = Photo.get_first(client)
        end
        log.section('Delete the photo') do
          # This should fail, because JSONplaceholder will not actually delete the photo.
          DeletePhotosId.verdict_call_and_verify_success(client, log, 'delete photo', photo_to_delete)
        end
      end
    end
  end

  def test_get_photos

    prelude do |client, log|
      log.section('Test GetPhotos') do
        GetPhotos.verdict_call_and_verify_success(client, log, 'get photos')
      end
    end

  end

  def test_get_photos_id

    prelude do |client, log|
      log.section('Test GetPhotosId') do
        photo_to_fetch = nil
        log.section('Get a photo to fetch') do
          photo_to_fetch = Photo.get_first(client)
        end
        log.section('Fetch the photo') do
          GetPhotosId.verdict_call_and_verify_success(client, log, 'get photo', photo_to_fetch)
        end
      end
    end

  end

  def test_post_photos

    prelude do |client, log|
      log.section('Test PostPhotos') do
        photo_to_post = Photo.new(
            :albumId => 1,
            :id => 1,
            :title => 'New title',
            :url => 'NewUrl',
            :thumbnailUrl => 'NewThumbmailUrl',
        )
        # This should fail, because JSONplaceholder will not actually create the photo.
        PostPhotos.verdict_call_and_verify_success(client, log, 'photo to_create', photo_to_post)
      end
    end

  end

  def test_put_photos_id

    prelude do |client, log|
      log.section('Test PutPhotos') do
        photo_to_put = nil
        log.section('Get a photo to put') do
          photo_original = Photo.get_first(client)
          photo_to_put = photo_original.clone
        end
        log.section('Put the modifications') do
          photo_to_put.title = 'New title'
          # This should fail, because JSONplaceholder will not actually update the photo.
          PutPhotosId.verdict_call_and_verify_success(client, log, 'Photo to put', photo_to_put)
        end
      end

    end

  end

end

