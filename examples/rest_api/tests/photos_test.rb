require_relative '../base_classes/base_class_for_test'

require_relative '../endpoints/photos/delete_photos_id'
require_relative '../endpoints/photos/get_photos'
require_relative '../endpoints/photos/get_photos_id'
require_relative '../endpoints/photos/post_photos'
require_relative '../endpoints/photos/put_photos_id'

class PhotosTest < BaseClassForTest

  def test_delete_photos_id

    prelude do |client, log|
      log.section('Test DeletePhotosId') do
        photo_to_delete = nil
        log.section('Get a photo to delete') do
          photo_to_delete = Photo.get_first(client)
        end
        log.section('Delete the photo') do
          # Some verdicts should fail, because JSONplaceholder will not actually delete the photo.
          DeletePhotosId.verdict_call_and_verify_success(client, log, 'delete photo', photo_to_delete)
        end
      end
    end
  end

  def test_get_photos

    prelude do |client, log|
      log.section('Test GetPhotos') do

        all_photos = nil

        log.section('GetPhotos with no query') do
          all_photos = GetPhotos.verdict_call_and_verify_success(client, log, 'with no query')
        end

        log.section('GetPhotos with simple query') do
          photo = all_photos.first
          query_elements = {
              :albumId => photo.albumId,
          }
          expected_photos = all_photos.select { |p| p.albumId == photo.albumId }
          actual_photos = GetPhotos.call(client, query_elements)
          if log.verdict_assert_equal?('count for simple query', expected_photos.size, actual_photos.size, 'Count')
            (0...expected_photos.size).each do |i|
              expected_photo = expected_photos[i]
              actual_photo = actual_photos[i]
              Photo.verdict_equal?(log, 'with simple query %d' % i, expected_photo, actual_photo, 'Photo %d' % i)
            end
          end
        end

        log.section('GetPhotos with complex query') do
          photo = all_photos.first
          query_elements = {
              :albumId => photo.albumId,
              :title => photo.title,
          }
          expected_photos = all_photos.select { |p| (p.albumId == photo.albumId) && (p.title == photo.title) }
          actual_photos = GetPhotos.call(client, query_elements)
          if log.verdict_assert_equal?('count for complex query', expected_photos.size, actual_photos.size, 'Count')
            (0...expected_photos.size).each do |i|
              expected_photo = expected_photos[i]
              actual_photo = actual_photos[i]
              Photo.verdict_equal?(log, 'with complex query %d' % i, expected_photo, actual_photo, 'Photo %d' % i)
            end
          end
        end

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
            :thumbnailUrl => 'NewThumbnailUrl',
        )
        # Some verdicts should fail, because JSONplaceholder will not actually create the photo.
        PostPhotos.verdict_call_and_verify_success(client, log, 'photo to_create', photo_to_post)
      end
    end

  end

  def test_put_photos_id

    prelude do |client, log|
      log.section('Test PutPhotosId') do
        photo_to_put = nil
        log.section('Get a photo to put') do
          photo_original = Photo.get_first(client)
          photo_to_put = photo_original.clone
        end
        log.section('Put the modifications') do
          photo_to_put.title = 'New title'
          photo_to_put.url = 'NewUrl'
          photo_to_put.thumbnailUrl = 'NewThumbnailUrl'
          # Some verdicts should fail, because JSONplaceholder will not actually update the photo.
          PutPhotosId.verdict_call_and_verify_success(client, log, 'Photo to put', photo_to_put)
        end
      end

    end

  end

end

