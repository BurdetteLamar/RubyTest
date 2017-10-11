require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/issue_label'

class DataEqualTest < BaseClassForTest

  def test_data_equal_simple
    prelude do |client, log|
      issue_label_0 = nil
      log.section('Fetch an instance of IssueLabel') do
        log.section('Fetch an issuelabel') do
          issue_label_0 = IssueLabel.get_first(client, 1)
        end
      end
      issue_label_1 = IssueLabel.deep_clone(issue_label_0)
      log.section('These are equal') do
        fail unless IssueLabel.equal?(issue_label_0, issue_label_1)
        IssueLabel.verdict_equal?(log, 'issue label equal', issue_label_0, issue_label_1, 'Using IssueLabel.verdict_equal?')
      end
      log.section('These are not equal') do
        issue_label_1.id += 1
        fail if IssueLabel.equal?(issue_label_0, issue_label_1)
        IssueLabel.verdict_equal?(log, 'issue label not equal', issue_label_0, issue_label_1, 'Using IssueLabel.verdict_equal?')
      end
    end
  end

end
