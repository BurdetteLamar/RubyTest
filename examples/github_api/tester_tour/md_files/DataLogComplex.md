<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Logging a Simple Data Object](./DataLogSimple.md#logging-a-simple-data-object)

**Next Stop:** [Creating a Simple Data Object](./DataNewSimple.md#creating-a-simple-data-object)


# Logging a Complex Data Object

This page introduces complex data classes, and shows how to log instances of them.

## Example Test

<code>data_log_complex_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/rate_limit'

class DataLogComplexTest < BaseClassForTest

  def test_data_log_complex
    prelude do |client, log|
      log.section('Fetch and log rate limit') do
        rate_limit = nil
        log.section('Fetch rate limit') do
          rate_limit = RateLimit.get(client)
        end
        rate_limit.log(log, 'Fetched rate limit')
      end
    end
  end

end

```

Notes:

- Class `RateLimit` derives from base classes that provide it with the ability to log itself, as seen here in the call to method `rate_limit.log`.
## Log

<code>test_data_log_complex.xml</code>
```xml
<data_log_complex_test>
  <summary errors='1' failures='1' verdicts='1'/>
  <test_method name='data_log_complex_test' timestamp='2017-10-12-Thu-15.32.32.960'>
    <section name='With GithubClient'>
      <section name='Fetch and log rate limit'>
        <section name='Fetch rate limit'>
          <GithubClient duration_seconds='1.449' method='GET' url='https://api.github.com/rate_limit'>
            <execution timestamp='2017-10-12-Thu-15.32.32.964'>
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
</data_log_complex_test>
```

Notes:

- The section named `Fetched rate limit` logs the values in the fetched rate limit.
- Nested data objects are recursively logged.
- The actual data returned by the client has this structure:

```ruby
{
    :resources => {
        :core => {
            :limit => 5000,
            :remaining => 4984,
            :reset => 1507676679,
        },
        :search => {
            :limit => 30,
            :remaining => 30,
            :reset => 1507673695,
        },
        :graphql => {
            :limit => 5000,
            :remaining => 5000,
            :reset => 1507677235,
        }
    },
    :rate => {
        :limit => 5000,
        :remaining => 4984,
        :reset => 1507676679,
    }
}
```
- The test framework automatically forms these nested hashes into nested objects.
- The nested objects recursively log themselves into nested log sections.

**Prev Stop:** [Logging a Simple Data Object](./DataLogSimple.md#logging-a-simple-data-object)

**Next Stop:** [Creating a Simple Data Object](./DataNewSimple.md#creating-a-simple-data-object)

