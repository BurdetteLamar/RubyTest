<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Creating a Data Object](./FlatDataNew.md#creating-a-data-object)

**Next Stop:** [Validating a Data Object](./FlatDataValid.md#validating-a-data-object)


# Verifying a Data Object

## Example Test

<code>flat_data_equal_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/issue_label'

class FlatDataEqualTest < BaseClassForTest

  def test_flat_data_equal
    prelude do |client, log|
      issue_label_0 = nil
      log.section('Fetch an instance of IssueLabel') do
        log.section('Fetch an issue label') do
          issue_label_0 = IssueLabel.get_first(client, 1)
        end
      end
      issue_label_1 = IssueLabel.deep_clone(issue_label_0)
      log.section('These are equal') do
        fail unless IssueLabel.equal?(issue_label_0, issue_label_1)
        IssueLabel.verdict_equal?(log, 'issue label equal', issue_label_0, issue_label_1, 'Using IssueLabel.verdict_equal?')
      end
      log.section('These are not equal') do
        issue_label_1.id += 1
        fail if IssueLabel.equal?(issue_label_0, issue_label_1)
        IssueLabel.verdict_equal?(log, 'issue label not equal', issue_label_0, issue_label_1, 'Using IssueLabel.verdict_equal?')
      end
    end
  end

end
```

Notes:

- Use method `equal?` to test data object equality, without logging.
- Use method `verdict_equal?` to test object equality, including logging.
- The test gets a known `IssueLabel`, then clones it.
- We know that `IssueLabel` is flat, but it's good practice to use `deep_clone`, not `clone` just to be sure.
- In section `These are equal`:
  - Method `IssueLabel.equal?` tests equality, but does no logging.
  - The `fail unless` proves that it worked.
  - Method `IssueLabel.verdict_equal?` verifies and logs each value in the issue labels.
- In section `These are not equal`:
  - One value in the issue label is modified.
  - Method `IssueLabel.equal?` tests equality, but does no logging.
  - The `fail if ` proves that it worked.
  - Method `IssueLabel.verdict_equal?` verifies and logs each value in the issue labels.

## Log

<code>test_flat_data_equal.xml</code>
```xml
<flat_data_equal_test>
  <summary errors='0' failures='1' verdicts='11'/>
  <test_method duration_seconds='1.945' name='flat_data_equal_test' timestamp='2017-10-16-Mon-16.19.25.975'>
    <section name='With GithubClient'>
      <section name='Fetch an instance of IssueLabel'>
        <section name='Fetch an issue label'>
          <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/issues/1/labels'>
            <execution duration_seconds='1.664' timestamp='2017-10-16-Mon-16.19.25.990'/>
          </GithubClient>
          <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/issues/1/labels'>
            <execution duration_seconds='0.264' timestamp='2017-10-16-Mon-16.19.27.654'/>
          </GithubClient>
        </section>
      </section>
      <section name='These are equal'>
        <verdict id='issue label equal-id' message='Using IssueLabel.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>710733210</exp_value>
          <act_value>710733210</act_value>
        </verdict>
        <verdict id='issue label equal-url' message='Using IssueLabel.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/enhancement</exp_value>
          <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/enhancement</act_value>
        </verdict>
        <verdict id='issue label equal-name' message='Using IssueLabel.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>enhancement</exp_value>
          <act_value>enhancement</act_value>
        </verdict>
        <verdict id='issue label equal-color' message='Using IssueLabel.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>84b6eb</exp_value>
          <act_value>84b6eb</act_value>
        </verdict>
        <verdict id='issue label equal-default' message='Using IssueLabel.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>true</exp_value>
          <act_value>true</act_value>
        </verdict>
      </section>
      <section name='These are not equal'>
        <verdict id='issue label not equal-id' message='Using IssueLabel.verdict_equal?' method='verdict_assert_equal?' outcome='failed' volatile='false'>
          <exp_value>710733210</exp_value>
          <act_value>710733211</act_value>
          <exception>
            <class>Minitest::Assertion</class>
            <message>Expected: 710733210 Actual: 710733211</message>
            <backtrace>
              <![CDATA[
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:144:in `block in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:133:in `verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:61:in `verdict_equal?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/flat_data_equal_test.rb:23:in `block (2 levels) in test_flat_data_equal'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/flat_data_equal_test.rb:20:in `block in test_flat_data_equal'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/flat_data_equal_test.rb:8:in `test_flat_data_equal']]>
            </backtrace>
          </exception>
        </verdict>
        <verdict id='issue label not equal-url' message='Using IssueLabel.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/enhancement</exp_value>
          <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/enhancement</act_value>
        </verdict>
        <verdict id='issue label not equal-name' message='Using IssueLabel.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>enhancement</exp_value>
          <act_value>enhancement</act_value>
        </verdict>
        <verdict id='issue label not equal-color' message='Using IssueLabel.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>84b6eb</exp_value>
          <act_value>84b6eb</act_value>
        </verdict>
        <verdict id='issue label not equal-default' message='Using IssueLabel.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>true</exp_value>
          <act_value>true</act_value>
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
</flat_data_equal_test>
```

Notes:

- Each actual value is verified in a separate verdict.
- In section `These are equal`, all verdicts pass.
- In section `These are not equal`, one verdict fails.

**Prev Stop:** [Creating a Data Object](./FlatDataNew.md#creating-a-data-object)

**Next Stop:** [Validating a Data Object](./FlatDataValid.md#validating-a-data-object)
