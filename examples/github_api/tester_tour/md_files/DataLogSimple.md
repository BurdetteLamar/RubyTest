<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Exceptions, Rescued and Not](./Exceptions.md)

**Next Stop:** [Logging a Complex Data Object](./DataLogComplex.md)


# Logging a Simple Data Object

This page introduces simple data classes, and shows how to log instances of them.

## Example Test

<code>data_log_simple_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/issue_label'

class DataNewTest < BaseClassForTest

  def test_data_log_simple
    prelude do |client, log|
      log.section('Fetch and log an instance of IssueLabel') do
        issue_label = nil
        log.section('Fetch an issue label') do
          issue_label = IssueLabel.get_first(client, 1)
        end
        issue_label.log(log, 'Fetched issue label')
      end
    end
  end

end
```

Notes:

- The GitHub API has numerous resources, including the issue-label resource.
- Class `IssueLabel` derives from base classes that provide it with the ability to log itself, as seen here in the call to method `issue_label.log`.

## Log

<code>test_data_log_simple.xml</code>
```xml
<data_log_simple_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='1.965' name='data_log_simple_test' timestamp='2017-10-11-Wed-18.15.20.205'>
    <section name='With GithubClient'>
      <section name='Fetch and log an instance of IssueLabel'>
        <section name='Fetch an issue label'>
          <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/issues/1/labels'>
            <execution duration_seconds='1.700' timestamp='2017-10-11-Wed-18.15.20.209'/>
          </GithubClient>
          <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/issues/1/labels'>
            <execution duration_seconds='0.259' timestamp='2017-10-11-Wed-18.15.21.911'/>
          </GithubClient>
        </section>
        <section name='Fetched issue label'>
          <data field='id' value='710733210'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/enhancement'/>
          <data field='name' value='enhancement'/>
          <data field='color' value='84b6eb'/>
          <data field='default' value='true'/>
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
</data_log_simple_test>
```

Notes:

- Element `GithubClient` records an interaction with the GitHub API, showing the HTTP method and url.
- Its subelement `execution` shows the timestamp and duration for the interaction.
- The section named `Fetched IssueLabel` shows the values in the fetched issue label.

**Prev Stop:** [Exceptions, Rescued and Not](./Exceptions.md)

**Next Stop:** [Logging a Complex Data Object](./DataLogComplex.md)

