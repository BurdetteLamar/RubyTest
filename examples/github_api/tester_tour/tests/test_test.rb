require_relative '../../base_classes/base_class_for_test'

class SimpleTest < BaseClassForTest

  def test_test
    prelude do |client, log|
      log.comment('Test code goes here')
      log.comment('Method prelude yields two objects:')
      log.comment('1. Instance of %s, for access to the GitHub API.' % client.class.name)
      log.comment('2. Instance of %s, for logging the test.' % log.class.name)
    end
  end

end