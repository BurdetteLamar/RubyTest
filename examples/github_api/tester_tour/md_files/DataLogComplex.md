<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Logging a Simple Data Object](./DataLogSimple.md)

**Next Stop:** [Creating a Simple Data Object](./DataNewSimple.md)


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
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='1.684' name='data_log_complex_test' timestamp='2017-10-10-Tue-19.05.27.263'>
    <section name='With GithubClient'>
      <section name='Fetch and log rate limit'>
        <section name='Fetch rate limit'>
          <GithubClient method='GET' url='https://api.github.com/rate_limit'>
            <execution duration_seconds='1.679' timestamp='2017-10-10-Tue-19.05.27.263'/>
          </GithubClient>
        </section>
        <section name='Fetched rate limit'>
          <section name='RateLimit::Resources'>
            <section name='RateLimit::Core'>
              <data field='limit' value='5000'/>
              <data field='remaining' value='4992'/>
              <data field='reset' value='1507683075'/>
            </section>
            <section name='RateLimit::Search'>
              <data field='limit' value='30'/>
              <data field='remaining' value='30'/>
              <data field='reset' value='1507680400'/>
            </section>
            <section name='RateLimit::Graphql'>
              <data field='limit' value='5000'/>
              <data field='remaining' value='5000'/>
              <data field='reset' value='1507683940'/>
            </section>
          </section>
          <section name='RateLimit::Rate'>
            <data field='limit' value='5000'/>
            <data field='remaining' value='4992'/>
            <data field='reset' value='1507683075'/>
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

**Prev Stop:** [Logging a Simple Data Object](./DataLogSimple.md)

**Next Stop:** [Creating a Simple Data Object](./DataNewSimple.md)

