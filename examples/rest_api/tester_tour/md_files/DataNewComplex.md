<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Creating a Simple Data Object](./DataNewSimple.md)

**Next Stop:** [Verifying a Simple Data Object](./DataEqualSimple.md)


# Creating a Complex Data Object

This page introduces complex data classes, and shows how to create instances of them.

## Example Test

<code>data_new_complex_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../../rest_api/data/user'

class DataNewComplexTest < BaseClassForTest

  def test_data_new_complex
    prelude do |_, log|
      log.section('Create and log an instance of a complex data object') do
        user = User.new(
            :id => nil,
            :name => 'Leanne Graham',
            :username => 'Bret',
            :email => 'Sincere@april.biz',
            :address => {
                :street => 'Kulas Light',
                :suite => 'Apt. 556',
                :city => 'Gwenborough',
                :zipcode => '92998-3874',
                :geo => {
                    :lat => '-37.3159',
                    :lng => '81.1496',
                }
            },
            :phone => '1-770-736-8031 x56442',
            :website => 'hildegard.org',
            :company => {
                :name => 'Romaguera-Crona',
                :catchPhrase => 'Multi-layered client-server neural-net',
                :bs => 'harness real-time e-markets',
            }
        )
        user.log(log)
      end
    end
  end

end
```

Notes:

- When the `User` instance is created, the values for `:address` are formed into an instance of `User::Address`.
- Similarly, the values for `:company` are formed into an instance of `User::Company`.
- There is a further nesting in the values for `:address`:  it contains multi-valued data for `:geo`.  These values are formed into an instance of `User::Address::Geo`.

## Log

<code>test_data_new_complex.xml</code>
```xml
<data_new_complex_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='0.004' name='data_new_complex_test' timestamp='2017-10-04-Wed-13.02.05.563'>
    <section name='With ExampleRestClient'>
      <section name='Create and log an instance of a complex data object'>
        <section name='User'>
          <data field='name' value='Leanne Graham'/>
          <data field='username' value='Bret'/>
          <data field='email' value='Sincere@april.biz'/>
          <section name='Field address is User::Address object'>
            <section name='User::Address'>
              <data field='street' value='Kulas Light'/>
              <data field='suite' value='Apt. 556'/>
              <data field='city' value='Gwenborough'/>
              <data field='zipcode' value='92998-3874'/>
              <section name='Field geo is User::Address::Geo object'>
                <section name='User::Address::Geo'>
                  <data field='lat' value='-37.3159'/>
                  <data field='lng' value='81.1496'/>
                </section>
              </section>
            </section>
          </section>
          <data field='phone' value='1-770-736-8031 x56442'/>
          <data field='website' value='hildegard.org'/>
          <section name='Field company is User::Company object'>
            <section name='User::Company'>
              <data field='name' value='Romaguera-Crona'/>
              <data field='catchPhrase' value='Multi-layered client-server neural-net'/>
              <data field='bs' value='harness real-time e-markets'/>
            </section>
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

**Prev Stop:** [Creating a Simple Data Object](./DataNewSimple.md)

**Next Stop:** [Verifying a Simple Data Object](./DataEqualSimple.md)

