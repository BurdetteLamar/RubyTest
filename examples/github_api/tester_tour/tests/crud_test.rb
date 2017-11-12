require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class CrudTest < BaseClassForTest

  def test_crud

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
        if ENV['NO_CRUD']
          # Here's how we create a label via the endpoint.
          require_relative '../../endpoints/labels/post_labels'
          label_created = PostLabels.call(client, label_to_create)
        else
          # And here's how via the CRUD method.
          label_created = Label.create(client, label_to_create)
        end
        label_created.log(log, 'Label created')
      end

      log.section('Read') do
        label_to_read = label_created
        label_to_read.log(log, 'Log to read')
        if ENV['NO_CRUD']
          # Here's how we read a label via the endpoint.
          require_relative '../../endpoints/labels/get_labels_name'
          label_read = GetLabelsName.call(client, label_to_read)
        else
          # And here's how via the CRUD method.
          label_read = Label.read(client, label_to_read)
        end
        label_read.log(log, 'Label read')
      end

      log.section('Update') do
        label_to_update = label_read
        label_to_update.color = 'ffffff'
        label_to_update.log(log, 'Label to update')
        if ENV['NO_CRUD']
          # Here's how we update a label via the endpoint.
          require_relative '../../endpoints/labels/patch_labels_name'
          label_updated = PatchLabelsName.call(client, label_to_update)
        else
          # And here's how via the CRUD method.
          label_updated = Label.update(client, label_to_update)
        end
        label_updated.log(log, 'Label updated')
      end

      log.section('Delete') do
        label_to_delete = label_updated
        if ENV['NO_CRUD']
          # Here's how we delete a label via the endpoint.
          require_relative '../../endpoints/labels/delete_labels_name'
          DeleteLabelsName.call(client, label_to_delete)
        else
          # And here's how via the CRUD method.
          Label.delete(client, label_to_delete)
        end
      end

    end

  end

end