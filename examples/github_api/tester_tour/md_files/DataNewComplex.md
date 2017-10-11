<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Creating a Simple Data Object](./DataNewSimple.md)


# Creating a Complex Data Object

This page shows how to create and log an instance of a complex data object.

## Example Test

<code>data_new_complex_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/rate_limit'

class DataNewComplexTest < BaseClassForTest

  def test_data_new_complex
    prelude do |_, log|
      log.section('Create and log an instance of a complex data object') do
        rate_limit = RateLimit.new(
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
        )
        rate_limit.log(log)
      end
    end
  end

end
```

Notes:

- The nested hashes are formed into nested data objects.
- Note that the instantiated objects exists only here in the test, and not in the Github API itself.

## Log

<code>test_data_new_complex.xml</code>
```xml
<data_new_complex_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='0.000' name='data_new_complex_test' timestamp='2017-10-11-Wed-15.56.09.919'>
    <section name='With GithubClient'>
      <section name='Create and log an instance of a complex data object'>
        <section name='RateLimit'>
          <section name='RateLimit::Resources'>
            <section name='RateLimit::Core'>
              <data field='limit' value='5000'/>
              <data field='remaining' value='4984'/>
              <data field='reset' value='1507676679'/>
            </section>
            <section name='RateLimit::Search'>
              <data field='limit' value='30'/>
              <data field='remaining' value='30'/>
              <data field='reset' value='1507673695'/>
            </section>
            <section name='RateLimit::Graphql'>
              <data field='limit' value='5000'/>
              <data field='remaining' value='5000'/>
              <data field='reset' value='1507677235'/>
            </section>
          </section>
          <section name='RateLimit::Rate'>
            <data field='limit' value='5000'/>
            <data field='remaining' value='4984'/>
            <data field='reset' value='1507676679'/>
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
</data_new_complex_test>
```

Notes:

- The structure of the logged nested objects:
  - `RateLimit`
    - `RateLimit::Resources`
      - `RateLimit::Core`
      - `RateLimit::Search`
      - `RateLimit::Graphql`
    - `RateLimit::Rate`

**Prev Stop:** [Creating a Simple Data Object](./DataNewSimple.md)

