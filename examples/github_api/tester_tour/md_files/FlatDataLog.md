<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [The Data Object](./DataObjects.md#the-data-object)

**Next Stop:** [Creating a Data Object](./FlatDataNew.md#creating-a-data-object)


# Logging a Data Object

A data object can log itself.

## Example Test

<code>flat_data_log_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class FlatDataLogTest < BaseClassForTest

  def test_flat_data_log
    prelude do |client, log|
      log.section('Fetch and log an instance of Label') do
        label = nil
        log.section('Fetch a label') do
          label = Label.get_first(client)
        end
        label.log(log, 'Fetched label')
      end
    end
  end

end
```

Notes:

- Log a data object by calling its `log` method.

## Log

<code>test_flat_data_log.xml</code>
```xml
<flat_data_log_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='3.485' name='flat_data_log_test' timestamp='2017-11-15-Wed-15.11.33.892'>
    <section name='With GithubClient'>
      <section name='Fetch and log an instance of Label'>
        <section name='Fetch a label'>
          <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels'>
            <execution duration_seconds='3.485' timestamp='2017-11-15-Wed-15.11.33.892'/>
          </GithubClient>
        </section>
        <section name='Fetched label'>
          <data field='id' value='562043326'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/bug'/>
          <data field='name' value='bug'/>
          <data field='color' value='ee0701'/>
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
</flat_data_log_test>
```

Notes:

- Element `GithubClient` records an interaction with the GitHub API, showing the HTTP method and url.
- Its subelement `execution` shows the timestamp and duration for the interaction.
- The section named `Fetched Label` shows the values in the fetched rate limit.

**Prev Stop:** [The Data Object](./DataObjects.md#the-data-object)

**Next Stop:** [Creating a Data Object](./FlatDataNew.md#creating-a-data-object)

