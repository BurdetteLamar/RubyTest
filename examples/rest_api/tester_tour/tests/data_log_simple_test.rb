require_relative '../../base_classes/base_class_for_test'

require_relative '../../../rest_api/data/album'

class DataNewTest < BaseClassForTest

  def test_data_log_simple
    prelude do |client, log|
      log.section('Fetch and log an instance of Album') do
        log.section('Fetch an album') do
          album = Album.get_first(client)
        end
        log.section('Log fetched album') do
          album.log(log)
        end
      end
    end
  end

end
