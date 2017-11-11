require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class FlatDataEqualTest < BaseClassForTest

  def test_flat_data_equal
    prelude do |client, log|
      label_0 = nil
      log.section('Fetch an instance of Label') do
        log.section('Fetch an label') do
          label_0 = Label.get_first(client)
        end
      end
      label_1 = Label.deep_clone(label_0)
      log.section('These are equal') do
        fail unless Label.equal?(label_0, label_1)
        Label.verdict_equal?(log, :label_equal, label_0, label_1, 'Using Label.verdict_equal?')
      end
      log.section('These are not equal') do
        label_1.id = Label.invalid_value_for(:id)
        fail if Label.equal?(label_0, label_1)
        Label.verdict_equal?(log, :label_not_equal, label_0, label_1, 'Using Label.verdict_equal?')
      end
    end
  end

end
