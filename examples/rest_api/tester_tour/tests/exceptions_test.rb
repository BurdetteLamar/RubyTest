require_relative '../../base_classes/base_class_for_test'

class ExceptionsTest < BaseClassForTest

  def test_exceptions
    prelude do |client, log|
      log.section('Section rescues exception', :rescue) do
        numerator = 1
        denominator = 0
        quotient = numerator / denominator
        log.section('This section is not reached because of the exception') do
          log.verdict_assert?('first not reached', quotient, 'Did not make it her because exception raised')
        end
      end
      log.section('This section is reached because the above exception was rescued') do
        log.verdict_assert?('reached', true, 'Made it to here')
      end
      log.section('Section does not rescue exception') do
        numerator = 1
        denominator = 0
        quotient = numerator / denominator
        log.section('This section is not reached because of the exception') do
          log.verdict_assert?('second not reached', quotient, 'Did not make it here because exception raised')
        end
      end
      log.section('This section is not reached because of the unrescued exception') do
        log.verdict_assert?('third not reached', true, 'Did not make it here because exception raised')
      end
    end
  end

end