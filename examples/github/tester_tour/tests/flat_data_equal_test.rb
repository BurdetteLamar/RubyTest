require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class FlatDataEqualTest < BaseClassForTest

  def test_flat_data_equal
    prelude do |log|
      with_api_client(log) do |api_client|
        label_0 = nil
        log.section('Fetch an instance of Label') do
          log.section('Fetch a label') do
            label_0 = Label.get_first(api_client)
          end
        end
        label_1 = Label.deep_clone(label_0)
        log.section('These are equal') do
          fail unless Label.equal?(label_0, label_1)
          Label.verdict_equal?(log, :label_equal, label_0, label_1)
        end
        log.section('These are not equal') do
          label_1.perturb!
          fail if Label.equal?(label_0, label_1)
          Label.verdict_equal?(log, :label_not_equal, label_0, label_1)
        end
      end
    end
  end

end
