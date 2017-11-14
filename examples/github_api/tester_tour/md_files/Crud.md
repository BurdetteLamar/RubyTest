<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [DeleteLabelsName Test](./DeleteLabelsName.md#deletelabelsname-test)

**Next Stop:** [Getters](./Getters.md#getters)


# CRUD

So far, most of the interactions with the API have been via the actual endpoint classes.

Many times, though, we'll want to access the API in a more convenient way, without our having to know details about the endpoints.

(Having to know the endpoint class name and call paramemters would not be burdensome for an API that's reliably consistent.  Testers:  when's the last time you saw an API that's reliably consistent?)

A data class can help with this by providing CRUD methods (Create, Read, Update, Delete) that perform the desired actions.

The <code>Label</code> class we've been working with does just that.

## Example Test

<code>crud_test.rb</code>
```ruby
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
          deleted = label_to_create.delete_if_exist?(client)
          log.comment(format('Deleted?  %s.', deleted ? 'Yes' : 'No'))
        end
        if ENV['NO_CRUD']
          # Here's how we create a label via the endpoint.
          require_relative '../../endpoints/labels/post_labels'
          label_created = PostLabels.call(client, label_to_create)
        else
          # And here's how via the CRUD method.
          label_created = label_to_create.create(client)
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
          label_read = label_to_read.read(client)
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
          label_updated = label_to_update.update(client)
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
          label_to_delete.delete(client)
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
  <test_method duration_seconds='4.922' name='crud_test' timestamp='2017-11-14-Tue-12.40.56.813'>
    <section name='With GithubClient'>
      <section name='Create'>
        <section name='Label to create'>
          <data field='name' value='label name'/>
          <data field='color' value='000000'/>
          <data field='default' value='false'/>
        </section>
        <section name='Delete if exists, to avoid collision'>
          <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/label%20name'>
            <execution duration_seconds='3.344' timestamp='2017-11-14-Tue-12.40.56.813'/>
          </GithubClient>
          <comment>Deleted? No.</comment>
        </section>
        <GithubClient method='POST' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels'>
          <parameters color='000000' name='label name'/>
          <execution duration_seconds='0.359' timestamp='2017-11-14-Tue-12.41.00.156'/>
        </GithubClient>
        <section name='Label created'>
          <data field='id' value='750392866'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/label%20name'/>
          <data field='name' value='label name'/>
          <data field='color' value='000000'/>
          <data field='default' value='false'/>
        </section>
      </section>
      <section name='Read'>
        <section name='Log to read'>
          <data field='id' value='750392866'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/label%20name'/>
          <data field='name' value='label name'/>
          <data field='color' value='000000'/>
          <data field='default' value='false'/>
        </section>
        <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/label%20name'>
          <execution duration_seconds='0.375' timestamp='2017-11-14-Tue-12.41.00.516'/>
        </GithubClient>
        <section name='Label read'>
          <data field='id' value='750392866'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/label%20name'/>
          <data field='name' value='label name'/>
          <data field='color' value='000000'/>
          <data field='default' value='false'/>
        </section>
      </section>
      <section name='Update'>
        <section name='Label to update'>
          <data field='id' value='750392866'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/label%20name'/>
          <data field='name' value='label name'/>
          <data field='color' value='ffffff'/>
          <data field='default' value='false'/>
        </section>
        <GithubClient method='PATCH' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/label%20name'>
          <parameters color='ffffff'/>
          <execution duration_seconds='0.391' timestamp='2017-11-14-Tue-12.41.00.891'/>
        </GithubClient>
        <section name='Label updated'>
          <data field='id' value='750392866'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/label%20name'/>
          <data field='name' value='label name'/>
          <data field='color' value='ffffff'/>
          <data field='default' value='false'/>
        </section>
      </section>
      <section name='Delete'>
        <GithubClient method='DELETE' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/label%20name'>
          <execution duration_seconds='0.453' timestamp='2017-11-14-Tue-12.41.01.282'/>
        </GithubClient>
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

**Prev Stop:** [DeleteLabelsName Test](./DeleteLabelsName.md#deletelabelsname-test)

**Next Stop:** [Getters](./Getters.md#getters)

