require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class GettersTest < BaseClassForTest

  def test_getters

    prelude do |log, api_client|

      log.section('Get the first label') do
        label = Label.get_first(api_client)
        label.log(log)
      end

      log.section('Get all labels') do
        labels = Label.get_all(api_client)
        labels.each do |label|
          label.log(log)
        end
      end

    end

  end

end