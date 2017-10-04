<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Logging a Simple Data Object](./DataLogSimple.md)

**Next Stop:** [Creating a Simple Data Object](./DataNewSimple.md)


# Logging a Complex Data Object

This page introduces complex data classes, and shows how to log instances of them.

## Example Test

<code>data_log_complex_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../../rest_api/data/user'

class DataLogComplexTest < BaseClassForTest

  def test_data_log_complex
    prelude do |client, log|
      log.section('Fetch and log an instance of User') do
        user = nil
        log.section('Fetch a user') do
          user = User.get_first(client)
        end
        user.log(log, 'Fetched user')
      end
    end
  end

end
```

Notes:

- Class `User` derives from base classes that provide it with the ability to log itself, as seen here in the call to method `user.log`.

## Log

<code>test_data_log_complex.xml</code>
```xml
<data_log_complex_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='1.542' name='data_log_complex_test' timestamp='2017-10-04-Wed-12.44.20.832'>
    <section name='With ExampleRestClient'>
      <section name='Fetch and log an instance of User'>
        <section name='Fetch a user'>
          <REST_API method='GET' url='https://jsonplaceholder.typicode.com/users'>
            <execution duration_seconds='1.529' timestamp='2017-10-04-Wed-12.44.20.836'/>
          </REST_API>
        </section>
        <section name='Fetched user'>
          <data field='id' value='1'/>
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
</data_log_complex_test>
```

Notes:

- Unlike an album, which has only scalar values, a user has a more complex structure.
- The section named `Fetched user' shows the values in the fetched user.
- Some of the values, such as those for `name` and `username`, are simple scalars.
- Other values, such as those for `address` and `company`, are more complex.
- The values for `address` are in an instance of `User::Address`.
- Similarly, the values for `company` are in an instance of `User::Company`.
- There is a further nesting in the values for `address`:  it contains multi-valued data for `geo`.  These values are in an instance of `User::Address::Geo`.

**Prev Stop:** [Logging a Simple Data Object](./DataLogSimple.md)

**Next Stop:** [Creating a Simple Data Object](./DataNewSimple.md)

