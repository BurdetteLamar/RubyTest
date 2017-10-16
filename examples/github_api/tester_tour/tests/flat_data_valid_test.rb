require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/issue_label'

class FlatDataValidTest < BaseClassForTest

  def test_flat_data_valid
    prelude do |client, log|
      issue_label = IssueLabel.get_first(client, 1)
      log.section('This is valid') do
        issue_label.verdict_valid?(log, 'issue label valid')
      end
      log.section('This is not valid') do
        issue_label.color = IssueLabel.invalid_value_for(:color)
        issue_label.verdict_valid?(log, 'issue label not valid')
      end
    end
  end

end
