<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Endpoint Tests](./EndpointTests.md#endpoint-tests)

**Next Stop:** [PostLabels Test](./PostLabels.md#postlabels-test)


# GetLabels Test

This is a test for endpoint `GET /labels`, which returns all labels.

## Example Test

<code>get_labels_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/labels/get_labels'

class LabelBasicsTest < BaseClassForTest

  def test_get_labels

    prelude do |client, log|

      log.section('Test GetLabels') do
        GetLabels.verdict_call_and_verify_success(client, log, 'Get labels')
      end

    end

  end

end
```

Notes:

- Class `GetLabels` encapsulates endpoint `GET /labels`.
- Method `GetLabels.verdict_call_and_verify_success`:
  - Accepts the client, the log, and a verdict id.
  - Accesses the endpoint.
  - Forms the returned data into an array of `Label` objects.
  - Performs verifications on those objects.
  - Returns the array.

## Log

<code>test_get_labels.xml</code>
```xml
<get_labels_test>
  <summary errors='0' failures='0' verdicts='8'/>
  <test_method name='get_labels_test' timestamp='2017-10-23-Mon-11.34.09.312'>
    <section duration_seconds='1.972' name='With GithubClient'>
      <section name='Test GetLabels'>
        <section name='Get labels' timestamp='2017-10-23-Mon-11.34.09.312'>
          <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels'>
            <execution duration_seconds='1.956' timestamp='2017-10-23-Mon-11.34.09.327'/>
          </GithubClient>
          <section name='Info'>
            <data fetched_labels_count='8'/>
            <section name='First label fetched'>
              <data field='id' value='710733208'/>
              <data field='url' value='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/bug'/>
              <data field='name' value='bug'/>
              <data field='color' value='ee0701'/>
              <data field='default' value='true'/>
            </section>
          </section>
          <section name='Evaluation'>
            <section name='Returned label valid'>
              <section name='verdict_assert_integer_positive?'>
                <verdict id='Get labels valid id - integer' message='id is positive integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                  <exp_value>Integer</exp_value>
                  <act_value>710733208</act_value>
                </verdict>
                <verdict id='Get labels valid id - positive' message='id is positive integer' method='verdict_assert_operator?' outcome='passed' volatile='false'>
                  <object_1>710733208</object_1>
                  <operator>:&gt;</operator>
                  <object_2>0</object_2>
                </verdict>
              </section>
              <verdict id='Get labels valid url' message='url starts with' method='verdict_assert_match?' outcome='passed' volatile='false'>
                <exp_value>/^https:\/\/api.github.com\/repos/</exp_value>
                <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/bug</act_value>
              </verdict>
              <section name='verdict_assert_string_not_empty?'>
                <verdict id='Get labels valid name - string' message='name is nonempty string' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                  <exp_value>String</exp_value>
                  <act_value>bug</act_value>
                </verdict>
                <verdict id='Get labels valid name - not empty' message='name is nonempty string' method='verdict_refute_empty?' outcome='passed' volatile='false'>
                  <act_value>bug</act_value>
                </verdict>
              </section>
              <verdict id='Get labels valid color' message='color is hex color' method='verdict_assert_match?' outcome='passed' volatile='false'>
                <exp_value>/[0-9a-f]{6}/i</exp_value>
                <act_value>ee0701</act_value>
              </verdict>
              <verdict id='Get labels valid default' message='default is boolean' method='verdict_assert_includes?' outcome='passed' volatile='false'>
                <exp_value>[TrueClass, FalseClass]</exp_value>
                <act_value>TrueClass</act_value>
              </verdict>
            </section>
          </section>
        </section>
      </section>
    </section>
    <section name='Count of errors (unexpected exceptions)'>
      <verdict id='error count' message='error count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
        <exp_value>0</exp_value>
        <act_value>0</act_value>
      </verdict>
    </section>
  </test_method>
</get_labels_test>
```

Notes:

- Section `GithubClient` shows the endpoint access.
- We don't know what labels to expect, so section `Info` just shows:
  - The count of labels.
  - The first label.
- Section 'Evaluation' shows validations for the first label.

**Prev Stop:** [Endpoint Tests](./EndpointTests.md#endpoint-tests)

**Next Stop:** [PostLabels Test](./PostLabels.md#postlabels-test)

