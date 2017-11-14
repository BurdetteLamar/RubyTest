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
          label_to_create.delete_if_exist?(client)
          label_to_delete = label_to_create.create(client)
        end
        log.section('Test deleting the created label') do
          DeleteLabelsName.verdict_call_and_verify_success(client, :delete_label, label_to_delete)
        end
        log.section('Clean up') do
          label_to_create.delete_if_exist?(client)
        end
      end

    end

  end

end