require_relative '../../base_classes/base_class_for_test'

class NothingTest < BaseClassForTest

  def test_nothing
    prelude do |client, log|
      # Test code goes here.
      # Citation of each keeps RubyMine inspection from complaining.
      p client
      p log
    end
  end

end