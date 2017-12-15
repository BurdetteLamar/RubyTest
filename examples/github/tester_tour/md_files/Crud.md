<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Resource Methods](./ResourceMethods.md#resource-methods)

**Next Stop:** [Getters](./Getters.md#getters)


# CRUD

Methods:

- `obj#create`
- `obj#read`
- `obj#update`
- `obj#delete`
s
## Example Test

<code>crud_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class CrudTest < BaseClassForTest

  def test_crud

    prelude do |log|

      with_api_client(log) do |api_client|

        label_created = nil
        label_read = nil
        label_updated = nil

        log.section('Create') do
          label_to_create = Label.provisioned
          label_to_create.log(log, 'Label to create')
          log.section('Delete if exists, to avoid collision') do
            deleted = label_to_create.delete_if_exist?(api_client)
            log.comment(format('Deleted?  %s.', deleted ? 'Yes' : 'No'))
          end
          if ENV['NO_CRUD']
            # Here's how we create a label via the endpoint.
            require_relative '../../endpoints/labels/post_labels'
            label_created = PostLabels.call(api_client, label_to_create)
          else
            # And here's how via the CRUD method.
            label_created = label_to_create.create(api_client)
          end
          label_created.log(log, 'Label created')
        end

        log.section('Read') do
          label_to_read = label_created
          label_to_read.log(log, 'Label to read')
          if ENV['NO_CRUD']
            # Here's how we read a label via the endpoint.
            require_relative '../../endpoints/labels/get_labels_name'
            label_read = GetLabelsName.call(api_client, label_to_read)
          else
            # And here's how via the CRUD method.
            label_read = label_to_read.read(api_client)
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
            label_updated = PatchLabelsName.call(api_client, label_to_update)
          else
            # And here's how via the CRUD method.
            label_updated = label_to_update.update(api_client)
          end
          label_updated.log(log, 'Label updated')
        end

        log.section('Delete') do
          label_to_delete = label_updated
          if ENV['NO_CRUD']
            # Here's how we delete a label via the endpoint.
            require_relative '../../endpoints/labels/delete_labels_name'
            DeleteLabelsName.call(api_client, label_to_delete)
          else
            # And here's how via the CRUD method.
            label_to_delete.delete(api_client)
          end
        end
      end

    end

  end

end
```

Notes:

- Here we create, read, update, and delete a <code>Label</code> object, using the CRUD methods (instead of accessing endpoints directly).
- The conditional passages show how we would do these both without and with the CRUD methods.
- Before creating, we delete the label, if it exists.

## Log

<code>test_crud.xml</code>
```xml
<crud_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='5.117' name='crud_test' timestamp='2017-12-15-Fri-15.27.27.726'>
    <section name='Test'>
      <section name='Create'>
        <section name='Label to create'>
          <data field='name' value='test label'/>
          <data field='color' value='000000'/>
          <data field='default' value='false'/>
        </section>
        <section name='Delete if exists, to avoid collision'>
          <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label'>
            <execution duration_seconds='3.619' timestamp='2017-12-15-Fri-15.27.27.742'/>
          </ApiClient>
          <comment>Deleted? No.</comment>
        </section>
        <ApiClient method='POST' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels'>
          <parameters color='000000' name='test label'/>
          <execution duration_seconds='0.390' timestamp='2017-12-15-Fri-15.27.31.361'/>
        </ApiClient>
        <section name='Label created'>
          <data field='id' value='780053973'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label'/>
          <data field='name' value='test label'/>
          <data field='color' value='000000'/>
          <data field='default' value='false'/>
        </section>
      </section>
      <section name='Read'>
        <section name='Label to read'>
          <data field='id' value='780053973'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label'/>
          <data field='name' value='test label'/>
          <data field='color' value='000000'/>
          <data field='default' value='false'/>
        </section>
        <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label'>
          <execution duration_seconds='0.374' timestamp='2017-12-15-Fri-15.27.31.751'/>
        </ApiClient>
        <section name='Label read'>
          <data field='id' value='780053973'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label'/>
          <data field='name' value='test label'/>
          <data field='color' value='000000'/>
          <data field='default' value='false'/>
        </section>
      </section>
      <section name='Update'>
        <section name='Label to update'>
          <data field='id' value='780053973'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label'/>
          <data field='name' value='test label'/>
          <data field='color' value='ffffff'/>
          <data field='default' value='false'/>
        </section>
        <ApiClient method='PATCH' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label'>
          <parameters color='ffffff'/>
          <execution duration_seconds='0.343' timestamp='2017-12-15-Fri-15.27.32.125'/>
        </ApiClient>
        <section name='Label updated'>
          <data field='id' value='780053973'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label'/>
          <data field='name' value='test label'/>
          <data field='color' value='ffffff'/>
          <data field='default' value='false'/>
        </section>
      </section>
      <section name='Delete'>
        <ApiClient method='DELETE' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label'>
          <execution duration_seconds='0.374' timestamp='2017-12-15-Fri-15.27.32.468'/>
        </ApiClient>
      </section>
    </section>
  </test_method>
  <section name='Count of errors (unexpected exceptions)'>
    <verdict id='error_count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>0</act_value>
    </verdict>
  </section>
</crud_test>
```

**Prev Stop:** [Resource Methods](./ResourceMethods.md#resource-methods)

**Next Stop:** [Getters](./Getters.md#getters)

