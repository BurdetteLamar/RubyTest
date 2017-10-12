<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Verifying a Simple Data Object](./DataEqualSimple.md#verifying-a-simple-data-object)

**Next Stop:** [Validating a Simple Data Object](./DataValidSimple.md#validating-a-simple-data-object)


# Verifying a Complex Data Object

## Example Test

<code>data_equal_complex_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/rate_limit'

class DataEqualTest < BaseClassForTest

  def test_data_equal_complex
    prelude do |client, log|
      rate_limit_0 = RateLimit.get(client)
      rate_limit_1 = RateLimit.deep_clone(rate_limit_0)
      log.section('These are equal') do
        fail unless RateLimit.equal?(rate_limit_0, rate_limit_1)
        RateLimit.verdict_equal?(log, 'rate limits equal', rate_limit_0, rate_limit_1, 'Using RateLimit.verdict_equal?')
      end
      log.section('These are not equal') do
        rate_limit_1.resources.core.limit += 1.0
        fail if RateLimit.equal?(rate_limit_0, rate_limit_1)
        RateLimit.verdict_equal?(log, 'rate limits not equal', rate_limit_0, rate_limit_1, 'Using RateLimit.verdict_equal?')
      end
    end
  end

end
```

Notes:

- The test gets a known `IssueLabel`, then clones it.
- We know that `IssueLabel` is complex, so it's _necessary_ to use `deep_clone`, not `clone`.
- In section `These are equal`:
  - Method `IssueLabel.equal?` tests equality, but does no logging.
  - The `fail unless` proves that it worked.
  - Method `IssueLabel.verdict_equal?` verifies and logs each value in the issue labels.
- In section `These are not equal`:
  - One value in the issue lable is modified.  The changed value is in a nested object.
  - Method `IssueLabel.equal?` test equality, but does no logging.
  - The `fail if ` proves that it worked.
  - Method `IssueLabel.verdict_equal?` verifies and logs each value in the users.

## Log

<code>test_data_equal_complex.xml</code>
```xml
<data_equal_complex_test>
  <summary errors='1' failures='1' verdicts='1'/>
  <test_method name='data_equal_complex_test' timestamp='2017-10-12-Thu-15.32.40.000'>
    <section name='With GithubClient'>
      <GithubClient duration_seconds='1.525' method='GET' url='https://api.github.com/rate_limit'>
        <execution timestamp='2017-10-12-Thu-15.32.40.004'>
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
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/endpoints/get_rate_limit.rb:12:in `call_and_return_payload'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_endpoint.rb:11:in `call'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/data/rate_limit.rb:29:in `get'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/data_equal_complex_test.rb:9:in `block in test_data_equal_complex'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/data_equal_complex_test.rb:8:in `test_data_equal_complex']]>
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
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/data_equal_complex_test.rb:8:in `test_data_equal_complex']]>
            </backtrace>
          </exception>
        </verdict>
      </section>
    </section>
  </test_method>
</data_equal_complex_test>
```

- Each actual value, even one that's in a nested object, is verified in a separate verdict.
- In section `These are equal`, all verdicts pass.
- In section `These are not equal`, one (deeply nested) verdict fails.

**Prev Stop:** [Verifying a Simple Data Object](./DataEqualSimple.md#verifying-a-simple-data-object)

**Next Stop:** [Validating a Simple Data Object](./DataValidSimple.md#validating-a-simple-data-object)

