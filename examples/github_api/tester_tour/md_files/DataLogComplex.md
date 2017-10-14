<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Logging a Simple Data Object](./DataLogSimple.md#logging-a-simple-data-object)

**Next Stop:** [Creating a Simple Data Object](./DataNewSimple.md#creating-a-simple-data-object)


# Logging a Complex Data Object

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

- Log a data object by calling its `log` method.

## Log

<code>test_data_log_complex.xml</code>
```xml
<data_log_complex_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='1.656' name='data_log_complex_test' timestamp='2017-10-14-Sat-10.56.32.399'>
    <section name='With GithubClient'>
      <section name='Fetch and log rate limit'>
        <section name='Fetch rate limit'>
          <GithubClient method='GET' url='https://api.github.com/rate_limit'>
            <execution duration_seconds='1.654' timestamp='2017-10-14-Sat-10.56.32.399'/>
          </GithubClient>
        </section>
        <section name='Fetched rate limit'>
          <section name='RateLimit::Resources'>
            <section name='RateLimit::Core_'>
              <data field='limit' value='5000'/>
              <data field='remaining' value='4968'/>
              <data field='reset' value='1507999225'/>
            </section>
            <section name='RateLimit::Search'>
              <data field='limit' value='30'/>
              <data field='remaining' value='30'/>
              <data field='reset' value='1507996668'/>
            </section>
            <section name='RateLimit::Graphql'>
              <data field='limit' value='5000'/>
              <data field='remaining' value='5000'/>
              <data field='reset' value='1508000208'/>
            </section>
          </section>
          <section name='RateLimit::Rate'>
            <data field='limit' value='5000'/>
            <data field='remaining' value='4968'/>
            <data field='reset' value='1507999225'/>
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
- The nested objects recursively log themselves into nested log sections.
- The structure of the logged nested objects:
  - `RateLimit`
    - `RateLimit::Resources`
      - `RateLimit::Core`
      - `RateLimit::Search`
      - `RateLimit::Graphql`
    - `RateLimit::Rate`

**Prev Stop:** [Logging a Simple Data Object](./DataLogSimple.md#logging-a-simple-data-object)

**Next Stop:** [Creating a Simple Data Object](./DataNewSimple.md#creating-a-simple-data-object)

