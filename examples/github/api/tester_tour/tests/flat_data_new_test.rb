require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class FlatDataNewTest < BaseClassForTest

  def test_flat_data_new
    prelude do |log, _|
      log.section('Instantiate and log an instance of Label') do
        label = Label.new(
            :id => 710733210,
            :url => 'https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/enhancement',
            :name => 'enhancement',
            :color => '84b6eb',
            :default => true,
        )
        log.section('Instantiated label') do
          label.log(log)
        end
      end
    end
  end

end
