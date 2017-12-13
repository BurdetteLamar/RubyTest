<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [CRUD](./Crud.md#crud)

**Next Stop:** [Existence Methods](./Existence.md#existence-methods)


# Getters

A data class may offer convenience methods for getting resources from the API.

## Example Test

<code>getters_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class GettersTest < BaseClassForTest

  def test_getters

    prelude do |log, api_client|

      log.section('Get the first label') do
        label = Label.get_first(api_client)
        label.log(log)
      end

      log.section('Get all labels') do
        labels = Label.get_all(api_client)
        labels.each do |label|
          label.log(log)
        end
      end

    end

  end

end
```

Notes:

- Method <code>Label.get_first</code> returns the first <code>Label</code> object.
- Method <code>Label.get_all</code> returns all <code>Label</code> objects.

## Log

<code>test_getters.xml</code>
```xml
<getters_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='2.090' name='getters_test' timestamp='2017-12-11-Mon-15.04.25.109'>
    <section name='Test'>
      <section name='Get the first label'>
        <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels'>
          <execution duration_seconds='1.747' timestamp='2017-12-11-Mon-15.04.25.109'/>
        </ApiClient>
        <section name='Label'>
          <data field='id' value='710733208'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/bug'/>
          <data field='name' value='bug'/>
          <data field='color' value='ee0701'/>
          <data field='default' value='true'/>
        </section>
      </section>
      <section name='Get all labels'>
        <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels'>
          <execution duration_seconds='0.343' timestamp='2017-12-11-Mon-15.04.26.857'/>
        </ApiClient>
        <section name='Label'>
          <data field='id' value='710733208'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/bug'/>
          <data field='name' value='bug'/>
          <data field='color' value='ee0701'/>
          <data field='default' value='true'/>
        </section>
        <section name='Label'>
          <data field='id' value='710733209'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/duplicate'/>
          <data field='name' value='duplicate'/>
          <data field='color' value='cccccc'/>
          <data field='default' value='true'/>
        </section>
        <section name='Label'>
          <data field='id' value='710733210'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/enhancement'/>
          <data field='name' value='enhancement'/>
          <data field='color' value='84b6eb'/>
          <data field='default' value='true'/>
        </section>
        <section name='Label'>
          <data field='id' value='710733213'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/good%20first%20issue'/>
          <data field='name' value='good first issue'/>
          <data field='color' value='7057ff'/>
          <data field='default' value='true'/>
        </section>
        <section name='Label'>
          <data field='id' value='710733211'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/help%20wanted'/>
          <data field='name' value='help wanted'/>
          <data field='color' value='33aa3f'/>
          <data field='default' value='true'/>
        </section>
        <section name='Label'>
          <data field='id' value='710733216'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/invalid'/>
          <data field='name' value='invalid'/>
          <data field='color' value='e6e6e6'/>
          <data field='default' value='true'/>
        </section>
        <section name='Label'>
          <data field='id' value='710733218'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/question'/>
          <data field='name' value='question'/>
          <data field='color' value='cc317c'/>
          <data field='default' value='true'/>
        </section>
        <section name='Label'>
          <data field='id' value='710733219'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/wontfix'/>
          <data field='name' value='wontfix'/>
          <data field='color' value='ffffff'/>
          <data field='default' value='true'/>
        </section>
      </section>
    </section>
  </test_method>
  <section name='Count of errors (unexpected exceptions)'>
    <verdict id='error_count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>0</act_value>
    </verdict>
  </section>
</getters_test>
```

**Prev Stop:** [CRUD](./Crud.md#crud)

**Next Stop:** [Existence Methods](./Existence.md#existence-methods)

