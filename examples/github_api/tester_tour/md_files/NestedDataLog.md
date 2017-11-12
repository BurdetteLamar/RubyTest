<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Validating a Data Object](./FlatDataValid.md#validating-a-data-object)

**Next Stop:** [Creating Nested Data Objects](./NestedDataNew.md#creating-nested-data-objects)


# Logging Nested Data Objects

Nested data objects can log themselves recursively.

Up to now, the data objects seen have been instances of class `Label`.

These objects are 'flat' in the sense that the values they store are all scalars:

- Integers.
- Strings.
- Booleans.

Now we begin to look at the handling of objects in class `RateLimit`, some of whose values are _not_ scalars, but are actually _other data objects_.  In other words, they're nested data objects.

## Example Test

<code>nested_data_log_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/rate_limit'

class NestedDataLogTest < BaseClassForTest

  def test_nested_data_log
    prelude do |client, log|
      log.section('Fetch and log a rate limit') do
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

- Log nested data objects by calling the `log` method.

## Log

<code>test_nested_data_log.xml</code>
```xml
<nested_data_log_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='3.344' name='nested_data_log_test' timestamp='2017-11-12-Sun-09.53.17.278'>
    <section name='With GithubClient'>
      <section name='Fetch and log a rate limit'>
        <section name='Fetch rate limit'>
          <GithubClient method='GET' url='https://api.github.com/rate_limit'>
            <execution duration_seconds='3.344' timestamp='2017-11-12-Sun-09.53.17.278'/>
          </GithubClient>
        </section>
        <section name='Fetched rate limit'>
          <section name='RateLimit::Resources'>
            <section name='RateLimit::Core_'>
              <data field='limit' value='5000'/>
              <data field='remaining' value='4996'/>
              <data field='reset' value='1510505278'/>
            </section>
            <section name='RateLimit::Search'>
              <data field='limit' value='30'/>
              <data field='remaining' value='30'/>
              <data field='reset' value='1510502062'/>
            </section>
            <section name='RateLimit::Graphql'>
              <data field='limit' value='5000'/>
              <data field='remaining' value='5000'/>
              <data field='reset' value='1510505602'/>
            </section>
          </section>
          <section name='RateLimit::Rate'>
            <data field='limit' value='5000'/>
            <data field='remaining' value='4996'/>
            <data field='reset' value='1510505278'/>
          </section>
        </section>
      </section>
    </section>
  </test_method>
  <section name='Count of errors (unexpected exceptions)'>
    <verdict id='error_count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>0</act_value>
    </verdict>
  </section>
</nested_data_log_test>
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

**Prev Stop:** [Validating a Data Object](./FlatDataValid.md#validating-a-data-object)

**Next Stop:** [Creating Nested Data Objects](./NestedDataNew.md#creating-nested-data-objects)

