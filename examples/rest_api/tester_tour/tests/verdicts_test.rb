require_relative '../../base_classes/base_class_for_test'

class VerdictsTest < BaseClassForTest

  def test_verdicts
    prelude do |client, log|
      # Citing client keeps RubyMine code inspection from complaining.
      client.class
      # Using extra variables in these verdicts, to make usage clear.
      log.section('These verdicts should pass') do
        log.section('An assertion verdict that should pass') do
          log.verdict_assert?(
              verdict_id = 'assertion should pass',
              actual = true,
              message = 'True is truthy'
          )
        end
        log.section('A refutation verdict that should pass') do
          log.verdict_refute?(
              verdict_id = 'refutation should pass',
              actual = false,
              message = 'False is not truthy'
          )
        end
      end
      log.section('These verdicts should fail') do
        log.section('An assert verdict that should fail') do
          log.verdict_assert?(
              verdict_id = 'assertion should fail',
              actual = false,
              message = 'False is not truthy'
          )
        end
        log.section('A refutation verdict that should fail') do
          log.verdict_refute?(
              verdict_id = 'refutation should fail',
              actual = true,
              message = 'True is truthy'
          )
        end
      end
    end
  end

end