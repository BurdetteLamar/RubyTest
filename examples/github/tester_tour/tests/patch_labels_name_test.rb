require_relative '../../base_classes/base_class_for_test'

require_relative '../../api/endpoints/labels/patch_labels_name'

class PatchLabelsNameTest < BaseClassForTest

  def test_patch_labels_name

    prelude do |log|

      with_api_client(log) do |api_client|

        log.section('Test PatchLabelsName') do
          label_to_create = Label.new(
              :id => nil,
              :url => nil,
              :name => 'test_label',
              :color => '000000',
              :default => false,
          )
          label_target = label_to_create.create!(api_client)
          label_source = label_target.perturb
          label_source.url = nil
          label_source.default = nil
          PatchLabelsName.verdict_call_and_verify_success(api_client, :patch_label, label_target, label_source)
          label_source.delete_if_exist?(api_client)
        end

      end

    end

  end

end