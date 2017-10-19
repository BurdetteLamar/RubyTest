require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/labels/post_labels'

class PostLabelsTest < BaseClassForTest

  def test_post_labels

    prelude do |client, log|

      label_created = nil
      log.section('Test PostLabels') do
        label_to_create = Label.new(
            :id => nil,
            :url => nil,
            :name => 'test_label',
            :color => '000000',
            :default => false,
        )
        Label.delete_if_exist?(client, label_to_create)
        label_created = PostLabels.verdict_call_and_verify_success(client, log, 'create label', label_to_create)
        Label.delete_if_exist?(client, label_created)

      end

    end

  end

end