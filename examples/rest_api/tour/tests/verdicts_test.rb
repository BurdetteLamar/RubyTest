require_relative '../../base_classes/base_class_for_test'

class VerdictsTest < BaseClassForTest

  def test_verdicts
    prelude do |client, log|
      log.section('A verdict that should pass') do
        # Using extra variables here, to make usage clear.
        log.verdict_assert?(
            verdict_id = 'different',
            actual = client != log,
            message = 'The client and log are not equal'
        )
      end
      log.section('A verdict that should fail') do
        log.verdict_refute?(
            verdict_id = 'same',
            actual = client != log,
            message = 'The client and log are equal'
        )
      end
    end
  end

end