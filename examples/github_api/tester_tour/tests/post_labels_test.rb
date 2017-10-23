require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/labels/post_labels'

class PostLabelsTest < BaseClassForTest

  def test_post_labels

    prelude do |client, log|

      label_to_create = Label.new(
          :id => nil,
          :url => nil,
          :name => 'test_label',
          :color => '000000',
          :default => false,
      )
      log.section('Test PostLabels') do
        Label.delete_if_exist?(client, label_to_create)
        PostLabels.verdict_call_and_verify_success(client, log, 'create label', label_to_create)
      end
      log.section('Clean up') do
        Label.delete_if_exist?(client, label_to_create)
      end

    end

  end

end