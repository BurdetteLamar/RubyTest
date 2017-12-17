require_relative '../../base_classes/base_class_for_test'

class MeetTest < BaseClassForTest

  def test_meet
    prelude do |log|
      log.comment('Method prelude yields an instance of %s, for logging the test.' % log.class.name)
      with_api_client(log) do |api_client|
        log.comment('Method with_api_client yields an instance of %s, for accessing the GitHub API' % api_client.class.name)
      end
      with_ui_client(log) do |ui_client, repo_page|
        log.comment('Method with_ui_client yields an instance of %s, for accessing the GitHub UI, and an instance of %s.' % [ui_client.class.name, repo_page.class.name])
      end
    end
  end

end