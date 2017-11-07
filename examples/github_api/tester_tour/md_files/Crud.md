<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [DeleteLabelsName Test](./DeleteLabelsName.md#deletelabelsname-test)

**Next Stop:** [More to Come ...](./MoreToCome.md#more-to-come-)


# CRUD Test

So far, most of the interactions with the API have been for the purpose of explicitly testing an endpoint.

Many times, though, we'll want to _make use of_ an endpoint without _sctually testing it_.

A data class can help with this by providing CRUD methods (create, read, update, delete) that simply perform the desired actions, without testing or logging.

The <code>Label</code> class we've been working with does that.

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
          deleted = Label.delete_if_exist?(client, label_to_create)
          log.comment(format('Deleted?  %s.', deleted ? 'Yes' : 'No'))
        end
        label_created = Label.create(client, label_to_create)
        label_created.log(log, 'Label created')
      end

      log.section('Read') do
        label_to_read = label_created
        label_to_read.log(log, 'Log to read')
        label_read = Label.read(client, label_to_read)
        label_read.log(log, 'Label read')
      end

      log.section('Update') do
        label_to_update = label_read
        label_to_update.color = 'ffffff'
        label_to_update.log(log, 'Label to update')
        label_updated = Label.update(client, label_read)
        label_updated.log(log, 'Label updated')
      end

      log.section('Delete') do
        label_to_delete = label_updated
        Label.delete(client, label_to_delete)
      end

    end

  end

end
```

Notes:

- Here we create, read, update, and delete a <code>Label</code> object, using the CRUD methods (instead of accessing endpoints directly).
- Before creating, we delete the label, if it exists.

## Log

<code>test_crud.xml</code>
```xml
<crud_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='5.203' name='crud_test' timestamp='2017-11-07-Tue-10.48.09.079'>
    <section name='With GithubClient'>
      <section name='Create'>
        <section name='Label to create'>
          <data field='name' value='label name'/>
          <data field='color' value='000000'/>
          <data field='default' value='false'/>
        </section>
        <section name='Delete if exists, to avoid collision'>
          <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/label%20name'>
            <execution duration_seconds='3.375' timestamp='2017-11-07-Tue-10.48.09.079'/>
          </GithubClient>
          <comment>Deleted? No.</comment>
        </section>
        <GithubClient method='POST' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels'>
          <parameters color='000000' name='label name'/>
          <execution duration_seconds='0.453' timestamp='2017-11-07-Tue-10.48.12.454'/>
        </GithubClient>
        <section name='Label created'>
          <data field='id' value='743407757'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/label%20name'/>
          <data field='name' value='label name'/>
          <data field='color' value='000000'/>
          <data field='default' value='false'/>
        </section>
      </section>
      <section name='Read'>
        <section name='Log to read'>
          <data field='id' value='743407757'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/label%20name'/>
          <data field='name' value='label name'/>
          <data field='color' value='000000'/>
          <data field='default' value='false'/>
        </section>
        <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/label%20name'>
          <execution duration_seconds='0.469' timestamp='2017-11-07-Tue-10.48.12.907'/>
        </GithubClient>
        <section name='Label read'>
          <data field='id' value='743407757'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/label%20name'/>
          <data field='name' value='label name'/>
          <data field='color' value='000000'/>
          <data field='default' value='false'/>
        </section>
      </section>
      <section name='Update'>
        <section name='Label to update'>
          <data field='id' value='743407757'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/label%20name'/>
          <data field='name' value='label name'/>
          <data field='color' value='ffffff'/>
          <data field='default' value='false'/>
        </section>
        <GithubClient method='PATCH' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/label%20name'>
          <parameters color='ffffff'/>
          <execution duration_seconds='0.422' timestamp='2017-11-07-Tue-10.48.13.376'/>
        </GithubClient>
        <section name='Label updated'>
          <data field='id' value='743407757'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/label%20name'/>
          <data field='name' value='label name'/>
          <data field='color' value='ffffff'/>
          <data field='default' value='false'/>
        </section>
      </section>
      <section name='Delete'>
        <GithubClient method='DELETE' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/label%20name'>
          <execution duration_seconds='0.484' timestamp='2017-11-07-Tue-10.48.13.798'/>
        </GithubClient>
      </section>
    </section>
  </test_method>
  <section name='Count of errors (unexpected exceptions)'>
    <verdict id='error_count' message='error count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>0</act_value>
    </verdict>
  </section>
</crud_test>
```

**Prev Stop:** [DeleteLabelsName Test](./DeleteLabelsName.md#deletelabelsname-test)

**Next Stop:** [More to Come ...](./MoreToCome.md#more-to-come-)

