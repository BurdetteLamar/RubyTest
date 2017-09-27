<!--- GENERATED FILE, DO NOT EDIT --->
[Prev](./DataNewSimple.md) [Next](./DataEqualSimple.md)

# Creating a Complex Data Object

This page introduces complex data classes, and shows how to create instances of them.

## Test Source Code

<code>data_new_complex_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../../rest_api/data/album'
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

- Unlike an album, which has only scalar values, a user has a more complex structure.
- Some of its values, such as those for <code>:name</code> and <code>:username</code>, are simple scalars.
- Other values, such as those for <code>:address</code> and <code>:company</code>, are more complex.
- When the <code>User</code> instance is created, the values for <code>:address</code> are formed into an instance of <code>User::Address</code>.
- Similarly, the values for <code>:company</code> are formed into an instance of <code>User::Company</code>.
- There is a further nesting in the values for <code>:address</code>:  it contains multi-valued data for <code>:geo</code>.  These values are formed into an instance of <code>User::Address::Geo</code>.

##  Test Log

<code>test_data_new_complex.xml</code>
```xml
<data_new_complex_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='0.010' name='data_new_complex_test' timestamp='2017-09-27-Wed-15.01.38.208'>
    <section name='With ExampleRestClient'>
      <section name='Create and log an instance of a complex data object'>
        <data field='name' value='Leanne Graham'/>
        <data field='username' value='Bret'/>
        <data field='email' value='Sincere@april.biz'/>
        <section name='Field address is User::Address object'>
          <data field='street' value='Kulas Light'/>
          <data field='suite' value='Apt. 556'/>
          <data field='city' value='Gwenborough'/>
          <data field='zipcode' value='92998-3874'/>
          <section name='Field geo is User::Address::Geo object'>
            <data field='lat' value='-37.3159'/>
            <data field='lng' value='81.1496'/>
          </section>
        </section>
        <data field='phone' value='1-770-736-8031 x56442'/>
        <data field='website' value='hildegard.org'/>
        <section name='Field company is User::Company object'>
          <data field='name' value='Romaguera-Crona'/>
          <data field='catchPhrase' value='Multi-layered client-server neural-net'/>
          <data field='bs' value='harness real-time e-markets'/>
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

- When the <code>User</code> object logs itself, the nested objects also log themselves.

[Prev](./DataNewSimple.md) [Next](./DataEqualSimple.md)
