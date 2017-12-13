require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class FlatDataValidTest < BaseClassForTest

  def test_flat_data_valid
    prelude do |log, api_client|
      label = Label.get_first(api_client)
      log.section('This is valid') do
        label.verdict_valid?(log, :label_valid)
      end
      log.section('This is not valid') do
        label.color = Label.invalid_value_for(:color)
        label.verdict_valid?(log, :label_not_valid)
      end
    end
  end

end
