require_relative '../../base_classes/base_class_for_test'

require_relative '../../../github_api/data/issue_label'

class FlatDataNewTest < BaseClassForTest

  def test_flat_data_new
    prelude do |_, log|
      log.section('Instantiate and log an instance of IssueLabel') do
        issue_label = IssueLabel.new(
            :id => 710733210,
            :url => 'https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/enhancement',
            :name => 'enhancement',
            :color => '84b6eb',
            :default => true,
        )
        log.section('Instantiated issue label') do
          issue_label.log(log)
        end
      end
    end
  end

end
