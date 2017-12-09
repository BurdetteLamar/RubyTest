require_relative '../../base_classes/base_class_for_test'

class RescuedExceptionTest < BaseClassForTest

  def test_rescued_exception
    prelude do |log, _|
      log.section('Rescued exception', :rescue) do
        numerator = 1
        denominator = 0
        quotient = numerator / denominator
        log.section('This section is not reached because of the exception') do
          log.verdict_assert?(:not_reached, quotient)
        end
      end
      log.section('This section is reached because the above exception was rescued') do
        log.verdict_assert?(:reached, true)
      end
    end
  end

end