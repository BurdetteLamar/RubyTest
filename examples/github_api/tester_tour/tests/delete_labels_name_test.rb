require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/labels/delete_labels_name'

class DeleteLabelsNameTest < BaseClassForTest

  def test_delete_labels_name

    prelude do |client, log|

      log.section('Test DeleteLabelsName') do
        label_to_create = nil
        label_to_delete = nil
        log.section('Create the label to be deleted') do
          label_to_create = Label.new(
              :id => nil,
              :url => nil,
              :name => 'test_label',
              :color => '000000',
              :default => false,
          )
          Label.delete_if_exist?(client, label_to_create)
          label_to_delete = Label.create(client, label_to_create)
        end
        log.section('Test deleting the created label') do
          DeleteLabelsName.verdict_call_and_verify_success(client, log, 'delete label', label_to_delete)
        end
        log.section('Clean up') do
          Label.delete_if_exist?(client, label_to_create)
        end
      end

    end

  end

end