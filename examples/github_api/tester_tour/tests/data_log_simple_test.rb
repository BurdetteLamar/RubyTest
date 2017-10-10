require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/issue_label'

class DataNewTest < BaseClassForTest

  def test_data_log_simple
    prelude do |client, log|
      log.section('Fetch and log an instance of IssueLabel') do
        issue_label = nil
        log.section('Fetch an issuelabel') do
          issue_label = IssueLabel.get_first(client, 1)
        end
        issue_label.log(log, 'Fetched issuelabel')
      end
    end
  end

end
