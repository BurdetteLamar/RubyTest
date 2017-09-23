require_relative '../../base_classes/base_class_for_test'

class ExceptionTest < BaseClassForTest

  def test_exception
    prelude do |client, log|
      log.section('Raise unexpected exception') do
        numerator = 1
        denominator = 0
        puts numerator / denominator
      end
    end
  end

end