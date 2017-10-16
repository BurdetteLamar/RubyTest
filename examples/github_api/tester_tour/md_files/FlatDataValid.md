<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Verifying a Data Object](./FlatDataEqual.md#verifying-a-data-object)

**Next Stop:** [Logging Nested Data Objects](./NestedDataLog.md#logging-nested-data-objects)


# Validating a Data Object

The term _valid_, as used here, is about whether a value is of the correct _form_.  This is as distinguished from the earlier term _equal_, which is about whether the value is _correct_.

Example of usefulness:  creating a new issue label returns an `IssueLabel` object with a new `id` value.  The _value_ of the `id` is unpredictable, but it is still useful to verify that it is a positive integer.

## Example Test

<code>flat_data_valid_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/issue_label'

class FlatDataValidTest < BaseClassForTest

  def test_flat_data_valid
    prelude do |client, log|
      issue_label = IssueLabel.get_first(client, 1)
      log.section('This is valid') do
        issue_label.verdict_valid?(log, 'issue label valid')
      end
      log.section('This is not valid') do
        issue_label.color = IssueLabel.invalid_value_for(:color)
        issue_label.verdict_valid?(log, 'issue label not valid')
      end
    end
  end

end
```

Notes:

- Use method `verdict_valid?` to verify that a data object's data are valid.
- In section `This is valid`:
  - A new `IssueLabel` with valid values is instantiated.
  - Method `IssueLabel.verdict_valid? validates and logs each value in the issue label.
- In section `This is not valid`:
  - A new `IssueLabel` with invalid values is instantiated.
  - Method `IssueLabel.verdict_valid? validates and logs each value in the issue label.
  - The invalid value is not in the test itself, but instead comes from the data class.

## Log

<code>test_flat_data_valid.xml</code>
```xml
<flat_data_valid_test>
  <summary errors='0' failures='1' verdicts='15'/>
  <test_method duration_seconds='1.945' name='flat_data_valid_test' timestamp='2017-10-16-Mon-16.19.29.002'>
    <section name='With GithubClient'>
      <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/issues/1/labels'>
        <execution duration_seconds='1.654' timestamp='2017-10-16-Mon-16.19.29.006'/>
      </GithubClient>
      <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/issues/1/labels'>
        <execution duration_seconds='0.270' timestamp='2017-10-16-Mon-16.19.30.661'/>
      </GithubClient>
      <section name='This is valid'>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='issue label valid id - integer' message='id is positive integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>710733210</act_value>
          </verdict>
          <verdict id='issue label valid id - positive' message='id is positive integer' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>710733210</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <verdict id='issue label valid url' message='url starts with' method='verdict_assert_match?' outcome='passed' volatile='false'>
          <exp_value>/^https:\/\/api.github.com\/repos/</exp_value>
          <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/enhancement</act_value>
        </verdict>
        <section name='verdict_assert_string_not_empty?'>
          <verdict id='issue label valid name - string' message='name is nonempty string' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>String</exp_value>
            <act_value>enhancement</act_value>
          </verdict>
          <verdict id='issue label valid name - not empty' message='name is nonempty string' method='verdict_refute_empty?' outcome='passed' volatile='false'>
            <act_value>enhancement</act_value>
          </verdict>
        </section>
        <verdict id='issue label valid color' message='color is hex color' method='verdict_assert_match?' outcome='passed' volatile='false'>
          <exp_value>/[0-9a-f]{6}/i</exp_value>
          <act_value>84b6eb</act_value>
        </verdict>
        <verdict id='issue label valid default' message='default is boolean' method='verdict_assert_includes?' outcome='passed' volatile='false'>
          <exp_value>[TrueClass, FalseClass]</exp_value>
          <act_value>TrueClass</act_value>
        </verdict>
      </section>
      <section name='This is not valid'>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='issue label not valid id - integer' message='id is positive integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>710733210</act_value>
          </verdict>
          <verdict id='issue label not valid id - positive' message='id is positive integer' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>710733210</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <verdict id='issue label not valid url' message='url starts with' method='verdict_assert_match?' outcome='passed' volatile='false'>
          <exp_value>/^https:\/\/api.github.com\/repos/</exp_value>
          <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/enhancement</act_value>
        </verdict>
        <section name='verdict_assert_string_not_empty?'>
          <verdict id='issue label not valid name - string' message='name is nonempty string' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>String</exp_value>
            <act_value>enhancement</act_value>
          </verdict>
          <verdict id='issue label not valid name - not empty' message='name is nonempty string' method='verdict_refute_empty?' outcome='passed' volatile='false'>
            <act_value>enhancement</act_value>
          </verdict>
        </section>
        <verdict id='issue label not valid color' message='color is hex color' method='verdict_assert_match?' outcome='failed' volatile='false'>
          <exp_value>/[0-9a-f]{6}/i</exp_value>
          <act_value>red</act_value>
          <exception>
            <class>Minitest::Assertion</class>
            <message>Expected /[0-9a-f]{6}/i to match # encoding: UTF-8 &quot;red&quot;.</message>
            <backtrace>
              <![CDATA[
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/data/issue_label.rb:37:in `verdict_field_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:42:in `block in verdict_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:41:in `verdict_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/flat_data_valid_test.rb:15:in `block (2 levels) in test_flat_data_valid'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/flat_data_valid_test.rb:13:in `block in test_flat_data_valid'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/flat_data_valid_test.rb:8:in `test_flat_data_valid']]>
            </backtrace>
          </exception>
        </verdict>
        <verdict id='issue label not valid default' message='default is boolean' method='verdict_assert_includes?' outcome='passed' volatile='false'>
          <exp_value>[TrueClass, FalseClass]</exp_value>
          <act_value>TrueClass</act_value>
        </verdict>
      </section>
    </section>
  </test_method>
  <section name='Count of errors (unexpected exceptions)'>
    <verdict id='error count' message='error count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>0</act_value>
    </verdict>
  </section>
</flat_data_valid_test>
```

Notes:

- In section `This is valid`, all verdicts pass.
- When a value has multiple validation verdicts (as all of these do), the verdicts are logged into a separate subsection.
- In section `This is not valid`, three verdicts fail.

**Prev Stop:** [Verifying a Data Object](./FlatDataEqual.md#verifying-a-data-object)

**Next Stop:** [Logging Nested Data Objects](./NestedDataLog.md#logging-nested-data-objects)

