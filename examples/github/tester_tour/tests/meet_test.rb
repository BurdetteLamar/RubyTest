require_relative '../../base_classes/base_class_for_test'

class MeetTest < BaseClassForTest

  def test_meet
    prelude do |log|
      log.comment('Method prelude yields an instance of %s, for logging the test.' % log.class.name)
      with_api_client(log) do |api_client|
        log.comment('Method with_api_client yields an instance of %s, for accessing the GitHub API' % api_client.class.name)
      end
    end
  end

end