require_relative '../../base_classes/base_class_for_test'

class VolatilityTest < BaseClassForTest

  def test_volatility
    prelude do |client, log|
      # Citing client keeps RubyMine code inspection from complaining.
      client.class
      log.section('Non-volatile value') do
        log.verdict_assert?('positive', Math.cos(0) > 0, 'Cos(0) positive')
      end
      log.section('Volatile value') do
        earlier = Time.now
        sleep 1
        later = Time.now
        log.verdict_assert?('sequence', earlier < later, 'Time order', volatile = true)
      end
    end
  end

end