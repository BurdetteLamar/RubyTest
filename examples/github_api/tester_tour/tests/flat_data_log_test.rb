require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class FlatDataLogTest < BaseClassForTest

  def test_flat_data_log
    prelude do |client, log|
      log.section('Fetch and log an instance of Label') do
        label = nil
        log.section('Fetch an label') do
          label = Label.get_first(client)
        end
        label.log(log, 'Fetched label')
      end
    end
  end

end
