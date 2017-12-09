require_relative '../../base_classes/base_class_for_test'

class VerdictsTest < BaseClassForTest

  def test_verdicts
    prelude do |log, _|
      # Using extra variables in these verdicts, to make usage clear.
      log.section('These verdicts should pass') do
        log.section('An assert verdict that should pass') do
          log.verdict_assert?(
              verdict_id = :assert_should_pass,
              actual = true,
          )
        end
        log.section('A refute verdict that should pass') do
          log.verdict_refute?(
              verdict_id = :refute_should_pass,
              actual = false,
          )
        end
      end
      log.section('These verdicts should fail') do
        log.section('An assert verdict that should fail') do
          log.verdict_assert?(
              verdict_id = :assert_should_fail,
              actual = false,
          )
        end
        log.section('A refute verdict that should fail') do
          log.verdict_refute?(
              verdict_id = :refute_should_fail,
              actual = true,
          )
        end
      end
    end
  end

end