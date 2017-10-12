<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Creating a Complex Data Object](./DataNewComplex.md#creating-a-complex-data-object)

**Next Stop:** [Verifying a Complex Data Object](./DataEqualComplex.md#verifying-a-complex-data-object)


# Verifying a Simple Data Object

## Example Test

<code>data_equal_simple_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/issue_label'

class DataEqualTest < BaseClassForTest

  def test_data_equal_simple
    prelude do |client, log|
      issue_label_0 = nil
      log.section('Fetch an instance of IssueLabel') do
        log.section('Fetch an issuelabel') do
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

<code>test_data_equal_simple.xml</code>
```xml
<data_equal_simple_test>
  <summary errors='1' failures='1' verdicts='1'/>
  <test_method name='data_equal_simple_test' timestamp='2017-10-12-Thu-15.32.37.443'>
    <section name='With GithubClient'>
      <section name='Fetch an instance of IssueLabel'>
        <section name='Fetch an issuelabel'>
          <GithubClient duration_seconds='1.535' method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/issues/1/labels'>
            <execution timestamp='2017-10-12-Thu-15.32.37.447'>
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
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/data_equal_simple_test.rb:12:in `block (3 levels) in test_data_equal_simple'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/data_equal_simple_test.rb:11:in `block (2 levels) in test_data_equal_simple'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/data_equal_simple_test.rb:10:in `block in test_data_equal_simple'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/data_equal_simple_test.rb:8:in `test_data_equal_simple']]>
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
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/data_equal_simple_test.rb:8:in `test_data_equal_simple']]>
                </backtrace>
              </exception>
            </verdict>
          </section>
        </section>
      </section>
    </section>
  </test_method>
</data_equal_simple_test>
```

Notes:

- Each actual value is verified in a separate verdict.
- In section `These are equal`, all verdicts pass.
- In section `These are not equal`, one verdict fails.

**Prev Stop:** [Creating a Complex Data Object](./DataNewComplex.md#creating-a-complex-data-object)

**Next Stop:** [Verifying a Complex Data Object](./DataEqualComplex.md#verifying-a-complex-data-object)

