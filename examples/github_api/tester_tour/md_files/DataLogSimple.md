<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Verdicts](./Verdicts.md#verdicts)

**Next Stop:** [Logging a Complex Data Object](./DataLogComplex.md#logging-a-complex-data-object)


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
  <summary errors='1' failures='1' verdicts='1'/>
  <test_method name='data_log_simple_test' timestamp='2017-10-12-Thu-15.32.30.488'>
    <section name='With GithubClient'>
      <section name='Fetch and log an instance of IssueLabel'>
        <section name='Fetch an issue label'>
          <GithubClient duration_seconds='1.461' method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/issues/1/labels'>
            <execution timestamp='2017-10-12-Thu-15.32.30.492'>
              <uncaught_exception>
                <verdict_id>With GithubClient</verdict_id>
                <class>RestClient::SSLCertificateNotVerified</class>
                <http_code>nil</http_code>
                <http_body>nil</http_body>
                <message>SSL_connect returned=1 errno=0 state=error: certificate verify failed</message>
                <backtrace>
                  <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:117:in `block (3 levels) in client_method'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:115:in `block (2 levels) in client_method'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:113:in `block in client_method'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:111:in `client_method'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:46:in `get'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/endpoints/get_issues_number_labels.rb:15:in `call_and_return_payload'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_endpoint.rb:11:in `call'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/data/issue_label.rb:66:in `get_all'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/data/issue_label.rb:71:in `get_first'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:11:in `prelude']]>
                </backtrace>
              </uncaught_exception>
            </execution>
          </GithubClient>
          <section name='Count of errors (unexpected exceptions)'>
            <verdict id='error count' message='error count' method='verdict_assert_equal?' outcome='failed' volatile='true'>
              <exp_value>0</exp_value>
              <act_value>1</act_value>
              <exception>
                <class>Minitest::Assertion</class>
                <message>Expected: 0 Actual: 1</message>
                <backtrace>
                  <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:11:in `prelude']]>
                </backtrace>
              </exception>
            </verdict>
          </section>
        </section>
      </section>
    </section>
  </test_method>
</data_log_simple_test>
```

Notes:

- Element `GithubClient` records an interaction with the GitHub API, showing the HTTP method and url.
- Its subelement `execution` shows the timestamp and duration for the interaction.
- The section named `Fetched IssueLabel` shows the values in the fetched issue label.

**Prev Stop:** [Verdicts](./Verdicts.md#verdicts)

**Next Stop:** [Logging a Complex Data Object](./DataLogComplex.md#logging-a-complex-data-object)

