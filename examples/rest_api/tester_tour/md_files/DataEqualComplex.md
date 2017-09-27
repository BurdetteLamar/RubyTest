<!--- GENERATED FILE, DO NOT EDIT --->
[Prev](./DataEqualSimple.md) 

# Complex Data Object Equality

## Test Source Code

<code>data_equal_complex_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../../rest_api/data/user'

class DataEqualTest < BaseClassForTest

  def test_data_equal_complex
    prelude do |client, log|
      user = User.get_first(client)
      User.equal?(user, user)
      User.verdict_equal?(log, 'user equal', user, user, 'Using User.verdict_equal?')
    end
  end

end
```

Notes:

##  Test Log

<code>test_data_equal_complex.xml</code>
```xml
<data_equal_complex_test>
  <summary errors='0' failures='0' verdicts='16'/>
  <test_method duration_seconds='1.488' name='data_equal_complex_test' timestamp='2017-09-27-Wed-08.47.04.245'>
    <section name='With ExampleRestClient'>
      <section duration_seconds='0.000' method='GET' name='Rest client' timestamp='2017-09-27-Wed-08.47.04.250' url='https://jsonplaceholder.typicode.com/users'>
        <parameters/>
      </section>
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
  </test_method>
  <section name='Count of errors (unexpected exceptions)'>
    <verdict id='error count' message='error count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>0</act_value>
    </verdict>
  </section>
</data_equal_complex_test>
```

[Prev](./DataEqualSimple.md) 
