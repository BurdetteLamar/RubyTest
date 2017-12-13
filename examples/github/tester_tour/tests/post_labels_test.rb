require_relative '../../base_classes/base_class_for_test'

require_relative '../../api/endpoints/labels/post_labels'

class PostLabelsTest < BaseClassForTest

  def test_post_labels

    prelude do |log, api_client|

      label_to_create = Label.new(
          :id => nil,
          :url => nil,
          :name => 'test_label',
          :color => '000000',
          :default => false,
      )
      log.section('Test PostLabels') do
        label_to_create.delete_if_exist?(api_client)
        PostLabels.verdict_call_and_verify_success(api_client, :post_label, label_to_create)
      end
      log.section('Clean up') do
        label_to_create.delete_if_exist?(api_client)
      end

    end

  end

end