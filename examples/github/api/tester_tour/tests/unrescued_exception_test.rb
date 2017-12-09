require_relative '../../base_classes/base_class_for_test'

class UnrescuedExceptionTest < BaseClassForTest

  def test_unrescued_exception
    prelude do |_, log|
      log.section('Unrescued exception') do
        numerator = 1
        denominator = 0
        quotient = numerator / denominator
        log.section('This section is not reached because of the exception') do
          log.verdict_assert?(:not_reached_in_section, quotient)
        end
      end
      log.section('This section is not reached because of the unrescued exception') do
        log.verdict_assert?(:not_reached_in_test, true)
      end
    end
  end

end