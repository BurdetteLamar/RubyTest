require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/labels/get_labels'

class LabelBasicsTest < BaseClassForTest

  def test_get_labels

    prelude do |client, log|

      log.section('Test GetLabels') do
        GetLabels.verdict_call_and_verify_success(client, 'Get labels')
      end

    end

  end

end