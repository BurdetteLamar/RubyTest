require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class ValidityTest < BaseClassForTest

  def test_validity

    prelude do |client, log|

      label = Label.get_first(client)

      log.section('Verify that a label is valid') do
        label.verdict_valid?(log, :valid)
      end

    end

  end

end