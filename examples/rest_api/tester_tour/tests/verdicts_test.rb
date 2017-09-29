require_relative '../../base_classes/base_class_for_test'

class VerdictsTest < BaseClassForTest

  def test_verdicts
    prelude do |_, log|
      # Using extra variables in these verdicts, to make usage clear.
      log.section('These verdicts should pass') do
        log.section('An assert verdict that should pass') do
          log.verdict_assert?(
              verdict_id = 'assert should pass',
              actual = true,
              message = 'True is truthy'
          )
        end
        log.section('A refute verdict that should pass') do
          log.verdict_refute?(
              verdict_id = 'refute should pass',
              actual = false,
              message = 'False is not truthy'
          )
        end
      end
      log.section('These verdicts should fail') do
        log.section('An assert verdict that should fail') do
          log.verdict_assert?(
              verdict_id = 'assert should fail',
              actual = false,
              message = 'False is not truthy'
          )
        end
        log.section('A refute verdict that should fail') do
          log.verdict_refute?(
              verdict_id = 'refute should fail',
              actual = true,
              message = 'True is truthy'
          )
        end
      end
    end
  end

end