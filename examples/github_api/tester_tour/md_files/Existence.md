<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Getters](./Getters.md#getters)

**Next Stop:** [Endpoint Objects](./EndpointObjects.md#endpoint-objects)


# Existence Methods

## Example Test

<code>existence_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class ExistenceTest < BaseClassForTest

  def test_existence

    prelude do |client, log|

      label_to_create = Label.new(
                                 :name => 'test_label',
                                 :color => '000000',
                                 :default => false,
      )

      existing_label = nil
      log.section('Create a label') do
        label_to_create.delete_if_exist?(client)
        existing_label = label_to_create.create(client)
      end

      log.section('Determine existence') do
        exist = existing_label.exist?(client)
        comment = format('Label exists? %s', exist)
        log.comment(comment)
      end

      log.section('Assert existence in verdict') do
        existing_label.verdict_assert_exist?(client, log, :assert_exist)
      end

      log.section('Delete if exist') do
        deleted = existing_label.delete_if_exist?(client)
        comment = format('Label deleted? %s', deleted)
        log.comment(comment)
      end

      log.section('Refute existence in verdict') do
        existing_label.verdict_refute_exist?(client, log, :refute_exist)
      end

    end

  end

end
```

Notes:

- `Label#exist?(client)` determines whether the label exists in the resource.
- `Label#verdict_assert_exist?(client, log, verdict_id)` logs a verdict asserting the label's existence.
- `Label#verdict_refute_exist?(client, log, verdict_id)` logs a verdict refuting the label's existence.
- `Label#delete_if_exist?(client)` deletes the label if it exists.

<code>test_existence.xml</code>
```xml
<existence_test>
  <summary errors='0' failures='0' verdicts='3'/>
  <test_method duration_seconds='5.703' name='existence_test' timestamp='2017-11-18-Sat-11.23.06.171'>
    <section name='With GithubClient'>
      <section name='Create a label'>
        <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test_label'>
          <execution duration_seconds='3.422' timestamp='2017-11-18-Sat-11.23.06.171'/>
        </GithubClient>
        <GithubClient method='POST' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels'>
          <parameters color='000000' name='test_label'/>
          <execution duration_seconds='0.422' timestamp='2017-11-18-Sat-11.23.09.593'/>
        </GithubClient>
      </section>
      <section name='Determine existence'>
        <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test_label'>
          <execution duration_seconds='0.344' timestamp='2017-11-18-Sat-11.23.10.015'/>
        </GithubClient>
        <comment>Label exists? true</comment>
      </section>
      <section name='Assert existence in verdict'>
        <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test_label'>
          <execution duration_seconds='0.391' timestamp='2017-11-18-Sat-11.23.10.359'/>
        </GithubClient>
        <verdict id='assert_exist' method='verdict_assert?' outcome='passed' volatile='false'>
          <act_value>true</act_value>
        </verdict>
      </section>
      <section name='Delete if exist'>
        <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test_label'>
          <execution duration_seconds='0.391' timestamp='2017-11-18-Sat-11.23.10.750'/>
        </GithubClient>
        <GithubClient method='DELETE' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test_label'>
          <execution duration_seconds='0.391' timestamp='2017-11-18-Sat-11.23.11.140'/>
        </GithubClient>
        <comment>Label deleted? true</comment>
      </section>
      <section name='Refute existence in verdict'>
        <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test_label'>
          <execution duration_seconds='0.344' timestamp='2017-11-18-Sat-11.23.11.531'/>
        </GithubClient>
        <verdict id='refute_exist' method='verdict_refute?' outcome='passed' volatile='false'>
          <act_value>false</act_value>
        </verdict>
      </section>
    </section>
  </test_method>
  <section name='Count of errors (unexpected exceptions)'>
    <verdict id='error_count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>0</act_value>
    </verdict>
  </section>
</existence_test>
```

**Prev Stop:** [Getters](./Getters.md#getters)

**Next Stop:** [Endpoint Objects](./EndpointObjects.md#endpoint-objects)

