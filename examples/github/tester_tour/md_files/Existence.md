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

    prelude do |log|

      with_api_client(log) do |api_client|

        label_to_create = Label.new(
                                   :name => 'test_label',
                                   :color => '000000',
                                   :default => false,
        )

        existing_label = nil
        log.section('Create a label') do
          label_to_create.delete_if_exist?(api_client)
          existing_label = label_to_create.create(api_client)
        end

        log.section('Determine existence') do
          exist = existing_label.exist?(api_client)
          comment = format('Label exists? %s', exist)
          log.comment(comment)
        end

        log.section('Assert existence in verdict') do
          existing_label.verdict_assert_exist?(api_client, log, :assert_exist)
        end

        log.section('Delete if exist') do
          deleted = existing_label.delete_if_exist?(api_client)
          comment = format('Label deleted? %s', deleted)
          log.comment(comment)
        end

        log.section('Refute existence in verdict') do
          existing_label.verdict_refute_exist?(api_client, log, :refute_exist)
        end

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
  <test_method duration_seconds='6.770' name='existence_test' timestamp='2017-12-18-Mon-09.46.04.343'>
    <section name='Test'>
      <section name='Create a label'>
        <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
          <execution duration_seconds='3.775' timestamp='2017-12-18-Mon-09.46.04.343'/>
        </ApiClient>
        <ApiClient method='POST' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels'>
          <parameters color='000000' name='test_label'/>
          <execution duration_seconds='0.359' timestamp='2017-12-18-Mon-09.46.08.118'/>
        </ApiClient>
      </section>
      <section name='Determine existence'>
        <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
          <execution duration_seconds='0.686' timestamp='2017-12-18-Mon-09.46.08.477'/>
        </ApiClient>
        <comment>Label exists? true</comment>
      </section>
      <section name='Assert existence in verdict'>
        <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
          <execution duration_seconds='0.827' timestamp='2017-12-18-Mon-09.46.09.163'/>
        </ApiClient>
        <verdict id='assert_exist' method='verdict_assert?' outcome='passed' volatile='false'>
          <act_value>true</act_value>
        </verdict>
      </section>
      <section name='Delete if exist'>
        <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
          <execution duration_seconds='0.328' timestamp='2017-12-18-Mon-09.46.09.990'/>
        </ApiClient>
        <ApiClient method='DELETE' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
          <execution duration_seconds='0.390' timestamp='2017-12-18-Mon-09.46.10.317'/>
        </ApiClient>
        <comment>Label deleted? true</comment>
      </section>
      <section name='Refute existence in verdict'>
        <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
          <execution duration_seconds='0.406' timestamp='2017-12-18-Mon-09.46.10.707'/>
        </ApiClient>
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

