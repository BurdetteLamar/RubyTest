<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Getters](./Getters.md#getters)

**Next Stop:** [Validity](./Validity.md#validity)


# Equality

A data class may offer convenience methods for determing and verifying equality.

## Example Test

<code>equality_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class EqualityTest < BaseClassForTest

  def test_equality

    prelude do |client, log|

      labels = Label.get_all(client)
      label_0 = labels[0]
      label_1 = labels[1]

      log.section('Determine whether two labels are equal') do
        equal = Label.equal?(label_0, label_1)
        comment = format('Equal?  %s', equal)
        log.comment(comment)
      end

      log.section('Verify that two labels are equal') do
        Label.verdict_equal?(log, :equal, label_0, label_1)
      end

    end

  end

end
```

Notes:

- Method <code>Label.equal?</code> determines whether two <code>Label</code> objects are equal.
- Method <code>Label.verdict_equal?></code> verifies (with logging) that two <code>Label</code> objects are equal.

## Log

<code>test_equality.xml</code>
```xml
<equality_test>
  <summary errors='0' failures='4' verdicts='6'/>
  <test_method duration_seconds='3.641' name='equality_test' timestamp='2017-11-14-Tue-12.41.07.692'>
    <section name='With GithubClient'>
      <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels'>
        <execution duration_seconds='3.485' timestamp='2017-11-14-Tue-12.41.07.692'/>
      </GithubClient>
      <section name='Determine whether two labels are equal'>
        <comment>Equal? false</comment>
      </section>
      <section name='Verify that two labels are equal'>
        <verdict id='equal:id' method='verdict_assert_equal?' outcome='failed' volatile='false'>
          <exp_value>562043326</exp_value>
          <act_value>562043327</act_value>
          <exception>
            <class>Minitest::Assertion</class>
            <message>Expected: 562043326 Actual: 562043327</message>
            <backtrace>
              <![CDATA[
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:146:in `block in verdict_equal_recursive?'
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:134:in `verdict_equal_recursive?'
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:62:in `verdict_equal?'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/equality_test.rb:22:in `block (2 levels) in test_equality'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/equality_test.rb:21:in `block in test_equality'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:20:in `block (2 levels) in prelude'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:20:in `block in with'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:16:in `with'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:19:in `block in prelude'
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:11:in `prelude'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/equality_test.rb:9:in `test_equality']]>
            </backtrace>
          </exception>
        </verdict>
        <verdict id='equal:url' method='verdict_assert_equal?' outcome='failed' volatile='false'>
          <exp_value>https://api.github.com/repos/BurdetteLamar/RubyTest/labels/bug</exp_value>
          <act_value>https://api.github.com/repos/BurdetteLamar/RubyTest/labels/duplicate</act_value>
          <exception>
            <class>Minitest::Assertion</class>
            <message>
              --- expected +++ actual @@ -1,2 +1,2 @@ # encoding: UTF-8
              -&quot;https://api.github.com/repos/BurdetteLamar/RubyTest/labels/bug&quot; +&quot;https://api.github.com/repos/BurdetteLamar/RubyTest/labels/duplicate&quot;
            </message>
            <backtrace>
              <![CDATA[
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:146:in `block in verdict_equal_recursive?'
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:134:in `verdict_equal_recursive?'
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:62:in `verdict_equal?'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/equality_test.rb:22:in `block (2 levels) in test_equality'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/equality_test.rb:21:in `block in test_equality'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:20:in `block (2 levels) in prelude'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:20:in `block in with'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:16:in `with'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:19:in `block in prelude'
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:11:in `prelude'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/equality_test.rb:9:in `test_equality']]>
            </backtrace>
          </exception>
        </verdict>
        <verdict id='equal:name' method='verdict_assert_equal?' outcome='failed' volatile='false'>
          <exp_value>bug</exp_value>
          <act_value>duplicate</act_value>
          <exception>
            <class>Minitest::Assertion</class>
            <message>
              --- expected +++ actual @@ -1,2 +1,2 @@ # encoding: UTF-8
              -&quot;bug&quot; +&quot;duplicate&quot;
            </message>
            <backtrace>
              <![CDATA[
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:146:in `block in verdict_equal_recursive?'
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:134:in `verdict_equal_recursive?'
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:62:in `verdict_equal?'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/equality_test.rb:22:in `block (2 levels) in test_equality'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/equality_test.rb:21:in `block in test_equality'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:20:in `block (2 levels) in prelude'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:20:in `block in with'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:16:in `with'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:19:in `block in prelude'
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:11:in `prelude'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/equality_test.rb:9:in `test_equality']]>
            </backtrace>
          </exception>
        </verdict>
        <verdict id='equal:color' method='verdict_assert_equal?' outcome='failed' volatile='false'>
          <exp_value>ee0701</exp_value>
          <act_value>cccccc</act_value>
          <exception>
            <class>Minitest::Assertion</class>
            <message>
              --- expected +++ actual @@ -1,2 +1,2 @@ # encoding: UTF-8
              -&quot;ee0701&quot; +&quot;cccccc&quot;
            </message>
            <backtrace>
              <![CDATA[
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:146:in `block in verdict_equal_recursive?'
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:134:in `verdict_equal_recursive?'
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:62:in `verdict_equal?'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/equality_test.rb:22:in `block (2 levels) in test_equality'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/equality_test.rb:21:in `block in test_equality'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:20:in `block (2 levels) in prelude'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:20:in `block in with'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:16:in `with'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:19:in `block in prelude'
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
C:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:11:in `prelude'
C:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/equality_test.rb:9:in `test_equality']]>
            </backtrace>
          </exception>
        </verdict>
        <verdict id='equal:default' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>true</exp_value>
          <act_value>true</act_value>
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
</equality_test>
```

**Prev Stop:** [Getters](./Getters.md#getters)

**Next Stop:** [Validity](./Validity.md#validity)

