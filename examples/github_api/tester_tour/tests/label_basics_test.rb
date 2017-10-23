require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/labels/delete_labels_name'
require_relative '../../endpoints/labels/get_labels'
require_relative '../../endpoints/labels/get_labels_name'
require_relative '../../endpoints/labels/patch_labels_name'
require_relative '../../endpoints/labels/post_labels'

class LabelBasicsTest < BaseClassForTest

  def test_label_basics

    prelude do |client, log|

      log.section('Test GetLabels') do
        GetLabels.verdict_call_and_verify_success(client, log, 'Get labels')
      end

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
      end

      log.section('Test GetLabelsName') do
        GetLabelsName.verdict_call_and_verify_success(client, log, 'get label', label_created)
      end

      label_updated = nil
      log.section('Test PatchLabelsName') do
        label_to_update = Label.deep_clone(label_created)
        label_to_update.color = 'ffffff'
        label_updated = PatchLabelsName.verdict_call_and_verify_success(client, log, 'update label', label_to_update)
      end

      log.section('Test DeleteLabelsName') do
        label_to_delete = Label.deep_clone(label_updated)
        DeleteLabelsName.verdict_call_and_verify_success(client, log, 'delete label', label_to_delete)
      end

    end

  end

end