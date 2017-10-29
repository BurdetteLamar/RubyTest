<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Creating Nested Data Objects](./NestedDataNew.md#creating-nested-data-objects)

**Next Stop:** [Verifying Nested Data Objects](./NestedDataEqual.md#verifying-nested-data-objects)


# Creating Nested Data Objects, Part 2

Nested data objects may be created using already-existing data objects.

In the previous stop, we saw how to create nested data objects using nested hashes.  That is, none of the nested objects existed prior to the single call to `new`.

Here we see how to create nested data objects using already-existing data objects.

## Example Test

<code>nested_data_new_2_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/rate_limit'

class NestedDataNewTest < BaseClassForTest

  def test_nested_data_new_2
    prelude do |_, log|
      log.section('Create and log nested data objects') do
        core = RateLimit::Core_.new(
            :limit => 5000,
            :remaining => 4984,
            :reset => 1507676679
        )
        search = RateLimit::Search.new(
            :limit => 30,
            :remaining => 30,
            :reset => 1507673695,
        )
        graphql = RateLimit::Graphql.new(
            :limit => 5000,
            :remaining => 5000,
            :reset => 1507677235,
        )
        resources = RateLimit::Resources.new(
            :core => core,
            :search => search,
            :graphql => graphql,
        )
        rate = RateLimit::Rate.new(
            :limit => 5000,
            :remaining => 4984,
            :reset => 1507676679,
        )
        rate_limit = RateLimit.new(
            {
                :resources => resources,
                :rate => rate,
            }
        )
        rate_limit.log(log)
      end
    end
  end

end
```

Notes:

- Create data objects individually by calling their `new` method.
- Instead of passing hashes as arguments, pass already-existing data objects.
- Note that the instantiated objects exists only here in the test, and not in the Github API itself.

## Log

<code>test_nested_data_new_2.xml</code>
```xml
<nested_data_new_2_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='0.004' name='nested_data_new_2_test' timestamp='2017-10-29-Sun-05.56.39.297'>
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
</nested_data_new_2_test>
```

**Prev Stop:** [Creating Nested Data Objects](./NestedDataNew.md#creating-nested-data-objects)

**Next Stop:** [Verifying Nested Data Objects](./NestedDataEqual.md#verifying-nested-data-objects)

