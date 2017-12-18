<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Verifying a Data Object](./FlatDataEqual.md#verifying-a-data-object)

**Next Stop:** [Logging Nested Data Objects](./NestedDataLog.md#logging-nested-data-objects)


# Validating a Data Object

A data object can validate itself.

The term _valid_, as used here, is about whether a value is of the correct _form_.  This is as distinguished from the earlier term _equal_, which is about whether the value is _correct_.

Example of usefulness:  creating a new label returns an `Label` object with a new `:id` value.  The _value_ of the `id` is unpredictable, but it is still useful to verify that it is a positive integer, as required.

## Example Test

<code>flat_data_valid_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class FlatDataValidTest < BaseClassForTest

  def test_flat_data_valid
    prelude do |log|
      with_api_client(log) do |api_client|
        label = Label.get_first(api_client)
        log.section('This is valid') do
          label.verdict_valid?(log, :label_valid)
        end
        log.section('This is not valid') do
          label.color = Label.invalid_value_for(:color)
          label.verdict_valid?(log, :label_not_valid)
        end
      end
    end
  end

end
```

Notes:

- Use method `verdict_valid?` to verify that a data object's data are valid.
- In section `This is valid`:
  - A new `Label` with valid values is instantiated.
  - Method `Label.verdict_valid? validates and logs each value in the rate limit.
- In section `This is not valid`:
  - A new `Label` with invalid values is instantiated.
  - Method `Label.verdict_valid? validates and logs each value in the rate limit.
  - The invalid value is not in the test itself, but instead comes from the data class.

## Log

<code>test_flat_data_valid.xml</code>
```xml
<flat_data_valid_test>
  <summary errors='0' failures='1' verdicts='15'/>
  <test_method duration_seconds='3.760' name='flat_data_valid_test' timestamp='2017-12-18-Mon-11.43.19.391'>
    <section name='Test'>
      <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels'>
        <execution duration_seconds='3.744' timestamp='2017-12-18-Mon-11.43.19.391'/>
      </ApiClient>
      <section name='This is valid'>
        <section class='Label' method='verdict_valid?' name='label_valid'>
          <section name='verdict_assert_integer_positive?'>
            <verdict id='label_valid:id:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
              <exp_value>Integer</exp_value>
              <act_value>710733208</act_value>
            </verdict>
            <verdict id='label_valid:id:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
              <object_1>710733208</object_1>
              <operator>:&gt;</operator>
              <object_2>0</object_2>
            </verdict>
          </section>
          <verdict id='label_valid:url' method='verdict_assert_match?' outcome='passed' volatile='false'>
            <exp_value>/^https:\/\/api.github.com\/repos/</exp_value>
            <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/bug</act_value>
          </verdict>
          <section name='verdict_assert_string_not_empty?'>
            <verdict id='label_valid:name:string' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
              <exp_value>String</exp_value>
              <act_value>bug</act_value>
            </verdict>
            <verdict id='label_valid:name:not_empty' method='verdict_refute_empty?' outcome='passed' volatile='false'>
              <act_value>bug</act_value>
            </verdict>
          </section>
          <verdict id='label_valid:color' method='verdict_assert_match?' outcome='passed' volatile='false'>
            <exp_value>/[0-9a-f]{6}/i</exp_value>
            <act_value>ee0701</act_value>
          </verdict>
          <verdict id='label_valid:default' method='verdict_assert_includes?' outcome='passed' volatile='false'>
            <exp_value>[TrueClass, FalseClass]</exp_value>
            <act_value>TrueClass</act_value>
          </verdict>
        </section>
      </section>
      <section name='This is not valid'>
        <section class='Label' method='verdict_valid?' name='label_not_valid'>
          <section name='verdict_assert_integer_positive?'>
            <verdict id='label_not_valid:id:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
              <exp_value>Integer</exp_value>
              <act_value>710733208</act_value>
            </verdict>
            <verdict id='label_not_valid:id:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
              <object_1>710733208</object_1>
              <operator>:&gt;</operator>
              <object_2>0</object_2>
            </verdict>
          </section>
          <verdict id='label_not_valid:url' method='verdict_assert_match?' outcome='passed' volatile='false'>
            <exp_value>/^https:\/\/api.github.com\/repos/</exp_value>
            <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/bug</act_value>
          </verdict>
          <section name='verdict_assert_string_not_empty?'>
            <verdict id='label_not_valid:name:string' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
              <exp_value>String</exp_value>
              <act_value>bug</act_value>
            </verdict>
            <verdict id='label_not_valid:name:not_empty' method='verdict_refute_empty?' outcome='passed' volatile='false'>
              <act_value>bug</act_value>
            </verdict>
          </section>
          <verdict id='label_not_valid:color' method='verdict_assert_match?' outcome='failed' volatile='false'>
            <exp_value>/[0-9a-f]{6}/i</exp_value>
            <act_value>red</act_value>
            <exception>
              <class>Minitest::Assertion</class>
              <message>Expected /[0-9a-f]{6}/i to match # encoding: UTF-8 &quot;red&quot;.</message>
              <backtrace>
                <![CDATA[
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/data/label.rb:33:in `verdict_field_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:48:in `block (2 levels) in verdict_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:46:in `block in verdict_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:45:in `verdict_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/flat_data_valid_test.rb:16:in `block (3 levels) in test_flat_data_valid'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/flat_data_valid_test.rb:14:in `block (2 levels) in test_flat_data_valid'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:28:in `block in with_api_client'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/api_client.rb:19:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:27:in `with_api_client'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/flat_data_valid_test.rb:9:in `block in test_flat_data_valid'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:21:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:20:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:12:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/flat_data_valid_test.rb:8:in `test_flat_data_valid']]>
              </backtrace>
            </exception>
          </verdict>
          <verdict id='label_not_valid:default' method='verdict_assert_includes?' outcome='passed' volatile='false'>
            <exp_value>[TrueClass, FalseClass]</exp_value>
            <act_value>TrueClass</act_value>
          </verdict>
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
</flat_data_valid_test>
```
s
Notes:

- In section `This is valid`, all verdicts pass.
- When a value has multiple validation verdicts (as all of these do), the verdicts are logged into a separate subsection.
- In section `This is not valid`, three verdicts fail.

**Prev Stop:** [Verifying a Data Object](./FlatDataEqual.md#verifying-a-data-object)

**Next Stop:** [Logging Nested Data Objects](./NestedDataLog.md#logging-nested-data-objects)

