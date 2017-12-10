require_relative '../../api/base_classes/base_class_for_test'

require_relative '../../data/label'

class FlatDataLogTest < BaseClassForTest

  def test_flat_data_log
    prelude do |log, api_client|
      log.section('Fetch and log an instance of Label') do
        label = nil
        log.section('Fetch a label') do
          label = Label.get_first(api_client)
        end
        label.log(log, 'Fetched label')
      end
    end
  end

end
