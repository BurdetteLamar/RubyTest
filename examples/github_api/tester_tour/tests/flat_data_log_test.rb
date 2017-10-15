require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/issue_label'

class FlatDataLogTest < BaseClassForTest

  def test_flat_data_log
    prelude do |client, log|
      log.section('Fetch and log an instance of IssueLabel') do
        issue_label = nil
        log.section('Fetch an issue label') do
          issue_label = IssueLabel.get_first(client, 1)
        end
        issue_label.log(log, 'Fetched issue label')
      end
    end
  end

end
