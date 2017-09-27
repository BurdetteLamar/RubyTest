<!--- GENERATED FILE, DO NOT EDIT --->
[Prev](./DataEqualSimple.md) [Next](./MoreToCome.md)

# Complex Data Object Equality

## Test Source Code

<code>data_equal_complex_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../../rest_api/data/user'

class DataEqualTest < BaseClassForTest

  def test_data_equal_complex
    prelude do |client, log|
      user_0 = User.get_first(client)
      user_1 = User.deep_clone(user_0)
      log.section('These are equal') do
        fail unless User.equal?(user_0, user_1)
        User.verdict_equal?(log, 'user equal', user_0, user_1, 'Using User.verdict_equal?')
      end
      log.section('These are not equal') do
        user_1.address.geo.lat += 1.0
        fail if User.equal?(user_0, user_1)
        User.verdict_equal?(log, 'user not equal', user_0, user_1, 'Using User.verdict_equal?')
      end
    end
  end

end
```

Notes:

- The test gets a known User, then clones it.
- We know that User is complex, so in this it's necessary to use <code>deep_clone</code>, not <code>clone</code>.
- In the first section:
  - Method <code>User.equal?</code> returns <code>true</code>, but does no logging.
  - The <code>fail unless</code> proves that it worked.
  - Method <code>User.verdict_equal?</code> verifies and logs each value in the users.
- In the second section:
  - One value in the user is modified.  The changed value is in a nested object.
  - Method <code>User.equal?</code> returns <code>false</code>, but does no logging.
  - The <code>fail if </code> proves that it worked.
  - Method <code>User.verdict_equal?</code> verifies and logs each value in the users.

##  Test Log

<code>test_data_equal_complex.xml</code>
```xml
<data_equal_complex_test>
  <summary errors='0' failures='1' verdicts='31'/>
  <test_method duration_seconds='1.532' name='data_equal_complex_test' timestamp='2017-09-27-Wed-15.09.15.889'>
    <section name='With ExampleRestClient'>
      <section duration_seconds='0.001' method='GET' name='Rest client' timestamp='2017-09-27-Wed-15.09.15.893' url='https://jsonplaceholder.typicode.com/users'>
        <parameters/>
      </section>
      <section name='These are equal'>
        <verdict id='user equal-id' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>1</exp_value>
          <act_value>1</act_value>
        </verdict>
        <verdict id='user equal-name' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>Leanne Graham</exp_value>
          <act_value>Leanne Graham</act_value>
        </verdict>
        <verdict id='user equal-username' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>Bret</exp_value>
          <act_value>Bret</act_value>
        </verdict>
        <verdict id='user equal-email' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>Sincere@april.biz</exp_value>
          <act_value>Sincere@april.biz</act_value>
        </verdict>
        <section name='User::Address'>
          <verdict id='user equal address-street' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>Kulas Light</exp_value>
            <act_value>Kulas Light</act_value>
          </verdict>
          <verdict id='user equal address-suite' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>Apt. 556</exp_value>
            <act_value>Apt. 556</act_value>
          </verdict>
          <verdict id='user equal address-city' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>Gwenborough</exp_value>
            <act_value>Gwenborough</act_value>
          </verdict>
          <verdict id='user equal address-zipcode' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>92998-3874</exp_value>
            <act_value>92998-3874</act_value>
          </verdict>
          <section name='User::Address::Geo'>
            <verdict id='user equal address geo-lat' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>-37.3159</exp_value>
              <act_value>-37.3159</act_value>
            </verdict>
            <verdict id='user equal address geo-lng' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>81.1496</exp_value>
              <act_value>81.1496</act_value>
            </verdict>
          </section>
        </section>
        <verdict id='user equal-phone' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>1-770-736-8031 x56442</exp_value>
          <act_value>1-770-736-8031 x56442</act_value>
        </verdict>
        <verdict id='user equal-website' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>hildegard.org</exp_value>
          <act_value>hildegard.org</act_value>
        </verdict>
        <section name='User::Company'>
          <verdict id='user equal company-name' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>Romaguera-Crona</exp_value>
            <act_value>Romaguera-Crona</act_value>
          </verdict>
          <verdict id='user equal company-catchphrase' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>Multi-layered client-server neural-net</exp_value>
            <act_value>Multi-layered client-server neural-net</act_value>
          </verdict>
          <verdict id='user equal company-bs' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>harness real-time e-markets</exp_value>
            <act_value>harness real-time e-markets</act_value>
          </verdict>
        </section>
      </section>
      <section name='These are not equal'>
        <verdict id='user not equal-id' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>1</exp_value>
          <act_value>1</act_value>
        </verdict>
        <verdict id='user not equal-name' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>Leanne Graham</exp_value>
          <act_value>Leanne Graham</act_value>
        </verdict>
        <verdict id='user not equal-username' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>Bret</exp_value>
          <act_value>Bret</act_value>
        </verdict>
        <verdict id='user not equal-email' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>Sincere@april.biz</exp_value>
          <act_value>Sincere@april.biz</act_value>
        </verdict>
        <section name='User::Address'>
          <verdict id='user not equal address-street' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>Kulas Light</exp_value>
            <act_value>Kulas Light</act_value>
          </verdict>
          <verdict id='user not equal address-suite' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>Apt. 556</exp_value>
            <act_value>Apt. 556</act_value>
          </verdict>
          <verdict id='user not equal address-city' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>Gwenborough</exp_value>
            <act_value>Gwenborough</act_value>
          </verdict>
          <verdict id='user not equal address-zipcode' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>92998-3874</exp_value>
            <act_value>92998-3874</act_value>
          </verdict>
          <section name='User::Address::Geo'>
            <verdict id='user not equal address geo-lat' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='failed' volatile='false'>
              <exp_value>-37.3159</exp_value>
              <act_value>-36.3159</act_value>
              <exception>
                <class>Minitest::Assertion</class>
                <message>Expected: -37.3159 Actual: -36.3159</message>
                <backtrace>
                  <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:129:in `block in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:118:in `verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:126:in `block (2 levels) in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:124:in `block in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:118:in `verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:126:in `block (2 levels) in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:124:in `block in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:118:in `verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:44:in `verdict_equal?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/data_equal_complex_test.rb:18:in `block (2 levels) in test_data_equal_complex'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/data_equal_complex_test.rb:15:in `block in test_data_equal_complex'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/data_equal_complex_test.rb:8:in `test_data_equal_complex']]>
                </backtrace>
              </exception>
            </verdict>
            <verdict id='user not equal address geo-lng' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>81.1496</exp_value>
              <act_value>81.1496</act_value>
            </verdict>
          </section>
        </section>
        <verdict id='user not equal-phone' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>1-770-736-8031 x56442</exp_value>
          <act_value>1-770-736-8031 x56442</act_value>
        </verdict>
        <verdict id='user not equal-website' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>hildegard.org</exp_value>
          <act_value>hildegard.org</act_value>
        </verdict>
        <section name='User::Company'>
          <verdict id='user not equal company-name' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>Romaguera-Crona</exp_value>
            <act_value>Romaguera-Crona</act_value>
          </verdict>
          <verdict id='user not equal company-catchphrase' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>Multi-layered client-server neural-net</exp_value>
            <act_value>Multi-layered client-server neural-net</act_value>
          </verdict>
          <verdict id='user not equal company-bs' message='Using User.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>harness real-time e-markets</exp_value>
            <act_value>harness real-time e-markets</act_value>
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
</data_equal_complex_test>
```

- In the first section, all verdicts pass.
- In the second section, one verdict fails.

[Prev](./DataEqualSimple.md) [Next](./MoreToCome.md)
