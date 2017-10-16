<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Logging Nested Data Objects](./NestedDataLog.md#logging-nested-data-objects)

**Next Stop:** [Verifying Nested Data Objects](./NestedDataEqual.md#verifying-nested-data-objects)


# Creating Nested Data Objects

## Example Test

<code>nested_data_new_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/rate_limit'

class NestedDataNewTest < BaseClassForTest

  def test_nested_data_new
    prelude do |_, log|
      log.section('Create and log nested data objects') do
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

- Create a new nested data object by calling method `new` on the data class.
- The nested hashes are formed into nested data objects.
- Note that the instantiated objects exists only here in the test, and not in the Github API itself.

## Log

<code>test_nested_data_new.xml</code>
```xml
<nested_data_new_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='0.003' name='nested_data_new_test' timestamp='2017-10-16-Mon-07.37.22.049'>
    <section name='With GithubClient'>
      <section name='Create and log nested data objects'>
        <section name='RateLimit'>
          <section name='RateLimit::Resources'>
            <section name='RateLimit::Core_'>
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
</nested_data_new_test>
```

**Prev Stop:** [Logging Nested Data Objects](./NestedDataLog.md#logging-nested-data-objects)

**Next Stop:** [Verifying Nested Data Objects](./NestedDataEqual.md#verifying-nested-data-objects)

