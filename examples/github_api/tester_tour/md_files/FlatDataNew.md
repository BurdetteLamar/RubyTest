<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Logging a Data Object](./FlatDataLog.md#logging-a-data-object)

**Next Stop:** [Verifying a Data Object](./FlatDataEqual.md#verifying-a-data-object)


# Creating a Data Object

## Example Test

<code>flat_data_new_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../../github_api/data/issue_label'

class FlatDataNewTest < BaseClassForTest

  def test_flat_data_new
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

- Create a new data object by calling method `new` on the data class.
- Pass the initial values in a hash of name/value pairs.
- (Note that the instantiated `IssueLabel` exists only here in the test, and not in the Github API itself.)

## Log

<code>test_flat_data_new.xml</code>
```xml
<flat_data_new_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='0.002' name='flat_data_new_test' timestamp='2017-10-16-Mon-07.37.12.417'>
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
</flat_data_new_test>
```

**Prev Stop:** [Logging a Data Object](./FlatDataLog.md#logging-a-data-object)

**Next Stop:** [Verifying a Data Object](./FlatDataEqual.md#verifying-a-data-object)

