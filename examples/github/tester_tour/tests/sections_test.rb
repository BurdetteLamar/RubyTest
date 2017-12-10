require_relative '../../api/base_classes/base_class_for_test'

class SectionsTest < BaseClassForTest

  def test_sections
    prelude do |log, _|
      log.section('First outer section') do
        log.section('First inner section') do
          log.comment('Some test code can go here')
        end
        log.section('Second inner section') do
          log.comment('Some test code can go here')
        end
      end
      log.section('Second outer section') do
        log.comment('Some test code can go here')
      end
      log.section('Section with timestamp', :timestamp) do
        log.comment('Some test code can go here')
      end
      log.section('Section with timestamp', :duration) do
        log.comment('Some test code can go here')
        sleep 1
      end
      log.section('Section with timestamp and duration', :timestamp, :duration) do
        log.comment('Some test code can go here')
        sleep 2
      end
      log.section('Order does not matter', :duration, :timestamp) do
        log.comment('Some test code can go here')
        sleep 3
      end
    end
  end

end