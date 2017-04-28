require_relative 'base_class_for_test'

require_relative '../endpoints/albums/delete_albums_id'
require_relative '../endpoints/albums/get_albums'
require_relative '../endpoints/albums/get_albums_id'
require_relative '../endpoints/albums/post_albums'
require_relative '../endpoints/albums/put_albums_id'

require_relative '../data/album'
require_relative '../../../lib/log/log'

class AlbumsTest < BaseClassForTest

  def test_delete_albums_id

    prelude do |client, log|
      log.section('Test DeleteAlbums') do
        album_to_delete = nil
        log.section('Get an album to delete') do
          album_to_delete = Album.get_first(client)
        end
        log.section('Delete the album') do
          # This should fail, because JSONplaceholder will not actually delete the album.
          DeleteAlbumsId.verdict_call_and_verify_success(client, log, 'delete album', album_to_delete)
        end
      end
    end
  end

  def test_get_albums

    prelude do |client, log|
      log.section('Test GetAlbums') do
        GetAlbums.verdict_call_and_verify_success(client, log, 'get albums')
      end
    end

  end

  def test_get_albums_id

    prelude do |client, log|
      log.section('Test GetAlbumsId') do
        album_to_fetch = nil
        log.section('Get an album to fetch') do
          album_to_fetch = Album.get_first(client)
        end
        log.section('Fetch the album') do
          GetAlbumsId.verdict_call_and_verify_success(client, log, 'get album', album_to_fetch)
        end
      end
    end

  end

  def test_post_albums

    prelude do |client, log|
      log.section('Test PostAlbums') do
        album_to_post = Album.new(
            :id => 1,
            :userId => 1,
            :title => 'My Album',
        )
        # This should fail, because JSONplaceholder will not actually create the album.
        PostAlbums.verdict_call_and_verify_success(client, log, 'album to_create', album_to_post)
      end
    end

  end

  def test_put_albums_id

    prelude do |client, log|
      log.section('Test PutAlbums') do
        album_to_put = nil
        log.section('Get a album to put') do
          album_original = Album.get_first(client)
          album_to_put = album_original.clone
        end
        log.section('Put the modifications') do
          album_to_put.title = 'New Title'
          # This should fail, because JSONplaceholder will not actually update the album.
          PutAlbumsId.verdict_call_and_verify_success(client, log, 'Album to put', album_to_put)
        end
      end

    end

  end

end
