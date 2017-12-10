require_relative '../../base_classes/base_class_for_test'

class MeetTest < BaseClassForTest

  def test_meet
    prelude do |log, api_client|

      log.comment('Test code goes here')

      log.comment('Method prelude yields two objects:')
      log.comment('1. Instance of %s, for logging the test.' % log.class.name)
      log.comment('2. Instance of %s, for access to the GitHub API.' % api_client.class.name)

    end
  end

end