<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Verifying a Complex Data Object](./DataEqualComplex.md#verifying-a-complex-data-object)

**Next Stop:** [Exceptions, Rescued and Not](./Exceptions.md#exceptions,-rescued-and-not)


# Validating a Simple Data Object

## Example Test

The term _valid_, as used here, is about whether a value is of the correct _form_.  This is as distinguished from the earlier term _equal_, which is about whether the value is _correct_.

For the values of `id` below, for example, the verifications are whether those values are positive integers.

Example of usefulness:  creating a new user returns a `User` object with a new `id` value.  The _value_ of the `id` is unpredictable, but it is still useful to verify that it is a positive integer.

<code>data_valid_simple_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/issue_label'

class DataValidSimpleTest < BaseClassForTest

  def test_data_valid_simple
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

- In section `This is valid`:
  - A new album with valid values is instantiated.
  - The valid values are not in the test itself, but instead come from the data class.
  - Method `Album.verdict_valid? validates and logs each value in the album.
- In section `This is not valid`:
  - A new album with invalid values is instantiated.
  - The invalid values are not in the test itself, but instead come from the data class.
  - Method `Album.verdict_valid? validates and logs each value in the album.

## Log

<code>test_data_valid_simple.xml</code>
```xml
<data_valid_simple_test>
  <summary errors='1' failures='1' verdicts='1'/>
  <test_method name='data_valid_simple_test' timestamp='2017-10-12-Thu-15.32.42.556'>
    <section name='With GithubClient'>
      <GithubClient duration_seconds='1.437' method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/issues/1/labels'>
        <execution timestamp='2017-10-12-Thu-15.32.42.560'>
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
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/data_valid_simple_test.rb:9:in `block in test_data_valid_simple'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/data_valid_simple_test.rb:8:in `test_data_valid_simple']]>
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
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/data_valid_simple_test.rb:8:in `test_data_valid_simple']]>
            </backtrace>
          </exception>
        </verdict>
      </section>
    </section>
  </test_method>
</data_valid_simple_test>
```

Notes:

- In section `This is valid`, all verdicts pass.
- When a value has multiple validation verdicts (as all of these do), the verdicts are logged into a separate subsection.
- In section `This is not valid`, three verdicts fail.

**Prev Stop:** [Verifying a Complex Data Object](./DataEqualComplex.md#verifying-a-complex-data-object)

**Next Stop:** [Exceptions, Rescued and Not](./Exceptions.md#exceptions,-rescued-and-not)

