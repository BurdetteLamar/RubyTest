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

require_relative '../../../data/rate_limit'

class NestedDataLogTest < BaseClassForTest

  def test_nested_data_log
    prelude do |log, api_client|
      log.section('Fetch and log a rate limit') do
        rate_limit = nil
        log.section('Fetch rate limit') do
          rate_limit = RateLimit.get(api_client)
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
  <test_method duration_seconds='1.747' name='nested_data_log_test' timestamp='2017-12-09-Sat-15.16.44.371'>
    <section name='Test'>
      <section name='Fetch and log a rate limit'>
        <section name='Fetch rate limit'>
          <ApiClient method='GET' url='https://api.github.com/rate_limit'>
            <execution duration_seconds='1.747' timestamp='2017-12-09-Sat-15.16.44.371'/>
          </ApiClient>
        </section>
        <section name='Fetched rate limit'>
          <section name='RateLimit::Resources'>
            <section name='RateLimit::Core_'>
              <data field='limit' value='5000'/>
              <data field='remaining' value='4989'/>
              <data field='reset' value='1512857786'/>
            </section>
            <section name='RateLimit::Search'>
              <data field='limit' value='30'/>
              <data field='remaining' value='30'/>
              <data field='reset' value='1512854271'/>
            </section>
            <section name='RateLimit::Graphql'>
              <data field='limit' value='5000'/>
              <data field='remaining' value='5000'/>
              <data field='reset' value='1512857811'/>
            </section>
          </section>
          <section name='RateLimit::Rate'>
            <data field='limit' value='5000'/>
            <data field='remaining' value='4989'/>
            <data field='reset' value='1512857786'/>
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

