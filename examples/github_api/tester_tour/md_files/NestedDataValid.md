<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Verifying Nested Data Objects](./NestedDataEqual.md#verifying-nested-data-objects)

**Next Stop:** [Endpoint Objects](./EndpointObjects.md#endpoint-objects)


# Validating Nested Data Objects

Nested data objects can be validated recursively.

## Example Test

<code>nested_data_valid_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/rate_limit'

class NestedDataValidTest < BaseClassForTest

  def test_nested_data_valid
    prelude do |client, log|
      rate_limit = RateLimit.get(client)
      log.section('This is valid') do
        rate_limit.verdict_valid?(log, :rate_limit_valid)
      end
      log.section('This is not valid') do
        rate_limit.resources.core.reset = RateLimit::Core_.invalid_value_for(:reset)
        rate_limit.verdict_valid?(log, :rate_limit_not_valid)
      end
    end
  end

end
```

Notes:

- Use method `verdict_valid?` to verify that a nested data object's values are valid.
- In section `This is valid`:
  - A new `RateLimit` with valid values is instantiated.
  - Method `RateLimit.verdict_valid? validates and logs each value in the rate limit.
- In section `This is not valid`:
  - A new `RateLimit` with invalid values is instantiated.
  - Method `RateLimit.verdict_valid? validates and logs each value in the rate limit.
  - The invalid value is not in the test itself, but instead comes from the data class.

## Log

<code>test_nested_data_valid.xml</code>
```xml
<nested_data_valid_test>
  <summary errors='0' failures='1' verdicts='49'/>
  <test_method duration_seconds='1.819' name='nested_data_valid_test' timestamp='2017-11-06-Mon-09.35.16.262'>
    <section name='With GithubClient'>
      <GithubClient method='GET' url='https://api.github.com/rate_limit'>
        <execution duration_seconds='1.778' timestamp='2017-11-06-Mon-09.35.16.262'/>
      </GithubClient>
      <section name='This is valid'>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_valid:resources:core:limit:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>5000</act_value>
          </verdict>
          <verdict id='rate_limit_valid:resources:core:limit:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>5000</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_valid:resources:core:remaining:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>4972</act_value>
          </verdict>
          <verdict id='rate_limit_valid:resources:core:remaining:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>4972</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_valid:resources:core:reset:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>1509986021</act_value>
          </verdict>
          <verdict id='rate_limit_valid:resources:core:reset:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>1509986021</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_valid:resources:search:limit:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>30</act_value>
          </verdict>
          <verdict id='rate_limit_valid:resources:search:limit:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>30</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_valid:resources:search:remaining:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>30</act_value>
          </verdict>
          <verdict id='rate_limit_valid:resources:search:remaining:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>30</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_valid:resources:search:reset:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>1509982588</act_value>
          </verdict>
          <verdict id='rate_limit_valid:resources:search:reset:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>1509982588</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_valid:resources:graphql:limit:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>5000</act_value>
          </verdict>
          <verdict id='rate_limit_valid:resources:graphql:limit:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>5000</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_valid:resources:graphql:remaining:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>5000</act_value>
          </verdict>
          <verdict id='rate_limit_valid:resources:graphql:remaining:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>5000</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_valid:resources:graphql:reset:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>1509986128</act_value>
          </verdict>
          <verdict id='rate_limit_valid:resources:graphql:reset:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>1509986128</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_valid:rate:limit:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>5000</act_value>
          </verdict>
          <verdict id='rate_limit_valid:rate:limit:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>5000</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_valid:rate:remaining:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>4972</act_value>
          </verdict>
          <verdict id='rate_limit_valid:rate:remaining:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>4972</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_valid:rate:reset:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>1509986021</act_value>
          </verdict>
          <verdict id='rate_limit_valid:rate:reset:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>1509986021</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
      </section>
      <section name='This is not valid'>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_not_valid:resources:core:limit:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>5000</act_value>
          </verdict>
          <verdict id='rate_limit_not_valid:resources:core:limit:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>5000</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_not_valid:resources:core:remaining:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>4972</act_value>
          </verdict>
          <verdict id='rate_limit_not_valid:resources:core:remaining:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>4972</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_not_valid:resources:core:reset:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>0</act_value>
          </verdict>
          <verdict id='rate_limit_not_valid:resources:core:reset:positive' method='verdict_assert_operator?' outcome='failed' volatile='false'>
            <object_1>0</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
            <exception>
              <class>Minitest::Assertion</class>
              <message>Expected 0 to be &gt; 0.</message>
              <backtrace>
                <![CDATA[
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/data/rate_limit.rb:51:in `verdict_field_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:43:in `block in verdict_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:41:in `verdict_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/data/rate_limit.rb:91:in `verdict_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/data/rate_limit.rb:23:in `verdict_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/nested_data_valid_test.rb:15:in `block (2 levels) in test_nested_data_valid'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/nested_data_valid_test.rb:13:in `block in test_nested_data_valid'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:20:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:20:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:16:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:19:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/nested_data_valid_test.rb:8:in `test_nested_data_valid']]>
              </backtrace>
            </exception>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_not_valid:resources:search:limit:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>30</act_value>
          </verdict>
          <verdict id='rate_limit_not_valid:resources:search:limit:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>30</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_not_valid:resources:search:remaining:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>30</act_value>
          </verdict>
          <verdict id='rate_limit_not_valid:resources:search:remaining:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>30</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_not_valid:resources:search:reset:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>1509982588</act_value>
          </verdict>
          <verdict id='rate_limit_not_valid:resources:search:reset:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>1509982588</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_not_valid:resources:graphql:limit:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>5000</act_value>
          </verdict>
          <verdict id='rate_limit_not_valid:resources:graphql:limit:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>5000</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_not_valid:resources:graphql:remaining:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>5000</act_value>
          </verdict>
          <verdict id='rate_limit_not_valid:resources:graphql:remaining:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>5000</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_not_valid:resources:graphql:reset:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>1509986128</act_value>
          </verdict>
          <verdict id='rate_limit_not_valid:resources:graphql:reset:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>1509986128</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_not_valid:rate:limit:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>5000</act_value>
          </verdict>
          <verdict id='rate_limit_not_valid:rate:limit:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>5000</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_not_valid:rate:remaining:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>4972</act_value>
          </verdict>
          <verdict id='rate_limit_not_valid:rate:remaining:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>4972</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='rate_limit_not_valid:rate:reset:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>1509986021</act_value>
          </verdict>
          <verdict id='rate_limit_not_valid:rate:reset:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>1509986021</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
      </section>
    </section>
  </test_method>
  <section name='Count of errors (unexpected exceptions)'>
    <verdict id='error_count' message='error count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>0</act_value>
    </verdict>
  </section>
</nested_data_valid_test>
```

Notes:

- In section `This is valid`, all verdicts pass.
- When a value has multiple validation verdicts (as all of these do), the verdicts are logged into a separate subsection.
- In section `This is not valid`, three verdicts fail.

**Prev Stop:** [Verifying Nested Data Objects](./NestedDataEqual.md#verifying-nested-data-objects)

**Next Stop:** [Endpoint Objects](./EndpointObjects.md#endpoint-objects)

