<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Creating Nested Data Objects, Part 2](./NestedDataNew2.md#creating-nested-data-objects-part-2)

**Next Stop:** [Validating Nested Data Objects](./NestedDataValid.md#validating-nested-data-objects)


# Verifying Nested Data Objects

## Example Test

<code>nested_data_equal_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/rate_limit'

class NestedDataEqualTest < BaseClassForTest

  def test_nested_data_equal
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

- Use method `equal?` to test nested data object equality, without logging.
- Use method `verdict_equal?` to test nested object equality, including logging.
- The test gets a known `IssueLabel`, then clones it.
- We know that `IssueLabel` has nested data objects, so it's _necessary_ to use `deep_clone`, not `clone`.
- In section `These are equal`:
  - Method `IssueLabel.equal?` tests equality, but does no logging.
  - The `fail unless` proves that it worked.
  - Method `IssueLabel.verdict_equal?` verifies and logs each value in the issue labels.
- In section `These are not equal`:
  - One value in the issue label is modified.  The changed value is in a nested object.
  - Method `IssueLabel.equal?` test equality, but does no logging.
  - The `fail if ` proves that it worked.
  - Method `IssueLabel.verdict_equal?` verifies and logs each value in the issue labels.

## Log

<code>test_nested_data_equal.xml</code>
```xml
<nested_data_equal_test>
  <summary errors='0' failures='1' verdicts='25'/>
  <test_method duration_seconds='1.790' name='nested_data_equal_test' timestamp='2017-10-21-Sat-18.21.49.402'>
    <section name='With GithubClient'>
      <GithubClient method='GET' url='https://api.github.com/rate_limit'>
        <execution duration_seconds='1.754' timestamp='2017-10-21-Sat-18.21.49.407'/>
      </GithubClient>
      <section name='These are equal'>
        <section name='RateLimit::Resources'>
          <section name='RateLimit::Core_'>
            <verdict id='rate limits equal resources core-limit' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>5000</exp_value>
              <act_value>5000</act_value>
            </verdict>
            <verdict id='rate limits equal resources core-remaining' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>4989</exp_value>
              <act_value>4989</act_value>
            </verdict>
            <verdict id='rate limits equal resources core-reset' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>1508631457</exp_value>
              <act_value>1508631457</act_value>
            </verdict>
          </section>
          <section name='RateLimit::Search'>
            <verdict id='rate limits equal resources search-limit' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>30</exp_value>
              <act_value>30</act_value>
            </verdict>
            <verdict id='rate limits equal resources search-remaining' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>30</exp_value>
              <act_value>30</act_value>
            </verdict>
            <verdict id='rate limits equal resources search-reset' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>1508628175</exp_value>
              <act_value>1508628175</act_value>
            </verdict>
          </section>
          <section name='RateLimit::Graphql'>
            <verdict id='rate limits equal resources graphql-limit' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>5000</exp_value>
              <act_value>5000</act_value>
            </verdict>
            <verdict id='rate limits equal resources graphql-remaining' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>5000</exp_value>
              <act_value>5000</act_value>
            </verdict>
            <verdict id='rate limits equal resources graphql-reset' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>1508631715</exp_value>
              <act_value>1508631715</act_value>
            </verdict>
          </section>
        </section>
        <section name='RateLimit::Rate'>
          <verdict id='rate limits equal rate-limit' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>5000</exp_value>
            <act_value>5000</act_value>
          </verdict>
          <verdict id='rate limits equal rate-remaining' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>4989</exp_value>
            <act_value>4989</act_value>
          </verdict>
          <verdict id='rate limits equal rate-reset' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>1508631457</exp_value>
            <act_value>1508631457</act_value>
          </verdict>
        </section>
      </section>
      <section name='These are not equal'>
        <section name='RateLimit::Resources'>
          <section name='RateLimit::Core_'>
            <verdict id='rate limits not equal resources core-limit' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='failed' volatile='false'>
              <exp_value>5000</exp_value>
              <act_value>5001.0</act_value>
              <exception>
                <class>Minitest::Assertion</class>
                <message>Expected: 5000 Actual: 5001.0</message>
                <backtrace>
                  <![CDATA[
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:145:in `block in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:134:in `verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:142:in `block (2 levels) in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:140:in `block in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:134:in `verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:142:in `block (2 levels) in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:140:in `block in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:134:in `verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:62:in `verdict_equal?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/nested_data_equal_test.rb:18:in `block (2 levels) in test_nested_data_equal'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/nested_data_equal_test.rb:15:in `block in test_nested_data_equal'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/nested_data_equal_test.rb:8:in `test_nested_data_equal']]>
                </backtrace>
              </exception>
            </verdict>
            <verdict id='rate limits not equal resources core-remaining' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>4989</exp_value>
              <act_value>4989</act_value>
            </verdict>
            <verdict id='rate limits not equal resources core-reset' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>1508631457</exp_value>
              <act_value>1508631457</act_value>
            </verdict>
          </section>
          <section name='RateLimit::Search'>
            <verdict id='rate limits not equal resources search-limit' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>30</exp_value>
              <act_value>30</act_value>
            </verdict>
            <verdict id='rate limits not equal resources search-remaining' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>30</exp_value>
              <act_value>30</act_value>
            </verdict>
            <verdict id='rate limits not equal resources search-reset' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>1508628175</exp_value>
              <act_value>1508628175</act_value>
            </verdict>
          </section>
          <section name='RateLimit::Graphql'>
            <verdict id='rate limits not equal resources graphql-limit' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>5000</exp_value>
              <act_value>5000</act_value>
            </verdict>
            <verdict id='rate limits not equal resources graphql-remaining' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>5000</exp_value>
              <act_value>5000</act_value>
            </verdict>
            <verdict id='rate limits not equal resources graphql-reset' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>1508631715</exp_value>
              <act_value>1508631715</act_value>
            </verdict>
          </section>
        </section>
        <section name='RateLimit::Rate'>
          <verdict id='rate limits not equal rate-limit' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>5000</exp_value>
            <act_value>5000</act_value>
          </verdict>
          <verdict id='rate limits not equal rate-remaining' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>4989</exp_value>
            <act_value>4989</act_value>
          </verdict>
          <verdict id='rate limits not equal rate-reset' message='Using RateLimit.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>1508631457</exp_value>
            <act_value>1508631457</act_value>
          </verdict>
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
</nested_data_equal_test>
```

- Each actual value, even one that's in a nested object, is verified in a separate verdict.
- In section `These are equal`, all verdicts pass.
- In section `These are not equal`, one (deeply nested) verdict fails.

**Prev Stop:** [Creating Nested Data Objects, Part 2](./NestedDataNew2.md#creating-nested-data-objects-part-2)

**Next Stop:** [Validating Nested Data Objects](./NestedDataValid.md#validating-nested-data-objects)

