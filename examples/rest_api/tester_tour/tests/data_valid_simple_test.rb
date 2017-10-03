require_relative '../../base_classes/base_class_for_test'

require_relative '../../../rest_api/data/album'

class DataValidTest < BaseClassForTest

  def test_data_valid_simple
    prelude do |_, log|
      log.section('This is valid') do
        album = Album.new(
            :id => Album.valid_id,
            :userId => Album.valid_user_id,
            :title => Album.valid_title,
        )
        album.verdict_valid?(log, 'album valid')
      end
      log.section('This is not valid') do
        album = Album.new(
            :id => Album.invalid_id,
            :userId => Album.invalid_user_id,
            :title => Album.invalid_title,
        )
        album.verdict_valid?(log, 'album not valid')
      end
    end
  end

end
