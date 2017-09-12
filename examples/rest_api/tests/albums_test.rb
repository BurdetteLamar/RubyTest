require_relative '../base_classes/base_class_for_test'

require_relative '../endpoints/albums/delete_albums_id'
require_relative '../endpoints/albums/get_albums'
require_relative '../endpoints/albums/get_albums_id'
require_relative '../endpoints/albums/post_albums'
require_relative '../endpoints/albums/put_albums_id'

class AlbumsTest < BaseClassForTest

  def test_delete_albums_id

    prelude do |client, log|
      log.section('Test DeleteAlbumsId') do
        album_to_delete = nil
        log.section('Get an album to delete') do
          album_to_delete = Album.get_first(client)
        end
        log.section('Delete the album') do
          DeleteAlbumsId.verdict_call_and_verify_success(client, log, 'delete album', album_to_delete)
        end
      end
    end
  end

  def test_get_albums

    prelude do |client, log|
      log.section('Test GetAlbums') do

        all_albums = nil

        log.section('GetAlbums with no query') do
          all_albums = GetAlbums.verdict_call_and_verify_success(client, log, 'with no query')
        end

        log.section('GetAlbums with simple query') do
          album = all_albums.first
          query_elements = {
              :userId => album.userId,
          }
          expected_albums = all_albums.select { |p| p.userId == album.userId }
          actual_albums = GetAlbums.call(client, query_elements)
          if log.verdict_assert_equal?('count for simple query', expected_albums.size, actual_albums.size, 'Count')
            (0...expected_albums.size).each do |i|
              expected_album = expected_albums[i]
              actual_album = actual_albums[i]
              Album.verdict_equal?(log, 'with simple query %d' % i, expected_album, actual_album, 'Album %d' % i)
            end
          end
        end

        log.section('GetAlbums with complex query') do
          album = all_albums.first
          query_elements = {
              :userId => album.userId,
              :title => album.title,
          }
          expected_albums = all_albums.select { |p| (p.userId == album.userId) && (p.title == album.title) }
          actual_albums = GetAlbums.call(client, query_elements)
          if log.verdict_assert_equal?('count for complex query', expected_albums.size, actual_albums.size, 'Count')
            (0...expected_albums.size).each do |i|
              expected_album = expected_albums[i]
              actual_album = actual_albums[i]
              Album.verdict_equal?(log, 'with complex query %d' % i, expected_album, actual_album, 'Album %d' % i)
            end
          end
        end

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
      log.section('Test AlbumAlbums') do
        album_to_album = Album.new(
            :id => 1,
            :userId => 1,
            :title => 'My Album',
        )
        PostAlbums.verdict_call_and_verify_success(client, log, 'album to_create', album_to_album)
      end
    end

  end

  def test_put_albums_id

    prelude do |client, log|
      log.section('Test PutAlbumsId') do
        album_to_put = nil
        log.section('Get a album to put') do
          album_original = Album.get_first(client)
          album_to_put = album_original.clone
        end
        log.section('Put the modifications') do
          album_to_put.title = 'New Title'
          PutAlbumsId.verdict_call_and_verify_success(client, log, 'Album to put', album_to_put)
        end
      end

    end

  end

end
