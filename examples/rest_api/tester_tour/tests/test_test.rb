require_relative '../../base_classes/base_class_for_test'

class NothingTest < BaseClassForTest

  def test_test
    prelude do |client, log|
      # Citing variables <code>client</code> and <code>log</code>
      # prevents RubyMine code inspection from complaining about unused variables.
      client.class
      log.class
    end
  end

end