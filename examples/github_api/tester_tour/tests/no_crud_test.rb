require_relative '../../base_classes/base_class_for_test'

require_relative '../../../github_api/endpoints/labels/post_labels'
require_relative '../../../github_api/endpoints/labels/get_labels_name'
require_relative '../../../github_api/endpoints/labels/patch_labels_name'
require_relative '../../../github_api/endpoints/labels/delete_labels_name'

class CrudTest < BaseClassForTest

  def test_no_crud

    prelude do |client, log|

      label_created = nil
      label_read = nil
      label_updated = nil

      log.section('Create') do
        label_to_create = Label.new(
            :name => 'label name',
            :color => '000000',
            :default => false,
        )
        label_to_create.log(log, 'Label to create')
        log.section('Delete if exists, to avoid collision') do
          deleted = Label.delete_if_exist?(client, label_to_create)
          log.comment(format('Deleted?  %s.', deleted ? 'Yes' : 'No'))
        end
        label_created = PostLables.call(client, label_to_create)
      end

      log.section('Read') do
        label_to_read = label_created
        label_to_read.log(log, 'Log to read')
        label_read = GetLabelsName.call(client, label_to_read)
        label_read.log(log, 'Label read')
      end

      log.section('Update') do
        label_to_update = label_read
        label_to_update.color = 'ffffff'
        label_to_update.log(log, 'Label to update')
        label_updated = PatchLabelsName.call(client, label_to_update)
        label_updated.log(log, 'Label updated')
      end

      log.section('Delete') do
        label_to_delete = label_updated
        DeleteLabelsName.call(client, label_to_delete)
      end

    end

  end

end