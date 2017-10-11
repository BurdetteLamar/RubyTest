<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Logging a Complex Data Object](./DataLogComplex.md)

**Next Stop:** [Creating a Complex Data Object](./DataNewComplex.md)


# Creating a Simple Data Object

This page introduces simple data classes, and shows how to create instances of them.

## Example Test

<code>data_new_simple_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../../github_api/data/issue_label'

class DataNewTest < BaseClassForTest

  def test_data_new_simple
    prelude do |_, log|
      log.section('Instantiate and log an instance of IssueLabel') do
        issue_label = IssueLabel.new(
            :id => 710733210,
            :url => 'https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/enhancement',
            :name => 'enhancement',
            :color => '84b6eb',
            :default => true,
        )
        log.section('Instantiated issue label') do
          issue_label.log(log)
        end
      end
    end
  end

end
```

Notes:

- These values are passed to method `IssueLabel.new` in a hash that gives the names and values.
- Note that the instantiated `IssueLabel` exists only here in the test, and not in the Github API itself.

## Log

<code>test_data_new_simple.xml</code>
```xml
<data_new_simple_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='0.002' name='data_new_simple_test' timestamp='2017-10-10-Tue-19.05.29.955'>
    <section name='With GithubClient'>
      <section name='Instantiate and log an instance of IssueLabel'>
        <section name='Instantiated issue label'>
          <section name='IssueLabel'>
            <data field='id' value='710733210'/>
            <data field='url' value='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/enhancement'/>
            <data field='name' value='enhancement'/>
            <data field='color' value='84b6eb'/>
            <data field='default' value='true'/>
          </section>
        </section>
      </section>
    </section>
  </test_method>
  <section name='Count of errors (unexpected exceptions)'>
    <verdict id='error count' message='error count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>0</act_value>
    </verdict>
  </section>
</data_new_simple_test>
```

**Prev Stop:** [Logging a Complex Data Object](./DataLogComplex.md)

**Next Stop:** [Creating a Complex Data Object](./DataNewComplex.md)
