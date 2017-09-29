<!--- GENERATED FILE, DO NOT EDIT --->
**Prev** [Logging a Simple Data Object](./DataLogSimple.md)

**Next** [Creating a Simple Data Object](./DataNewSimple.md)


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
        log.section('Fetch a user') do
          user = User.get_first(client)
        end
        log.section('Log fetched user') do
          user.log(log)
        end
      end
    end
  end

end
```

Notes:

- Unlike an album, which has only scalar values, a user has a more complex structure.
- Some of its values, such as those for `:name` and `:username`, are simple scalars.
- Other values, such as those for `:address` and `:company`, are more complex.
- When the `User` instance is created, the values for `:address` are formed into an instance of `User::Address`.
- Similarly, the values for `:company` are formed into an instance of `User::Company`.
- There is a further nesting in the values for `:address`:  it contains multi-valued data for `:geo`.  These values are formed into an instance of `User::Address::Geo`.
- Class `User` derives from base classes that provide it with the ability to log itself, as seen here in the call to method `user.log`.

## Log

<code>test_data_log_complex.xml</code>
```xml
<data_log_complex_test>
  <summary errors='1' failures='1' verdicts='1'/>
  <test_method name='data_log_complex_test' timestamp='2017-09-29-Fri-13.01.06.543'>
    <section name='With ExampleRestClient'>
      <section duration_seconds='1.589' name='Fetch and log an instance of User'>
        <section name='Fetch a user'>
          <section duration_seconds='0.000' method='GET' name='Rest client' timestamp='2017-09-29-Fri-13.01.06.543' url='https://jsonplaceholder.typicode.com/users'>
            <parameters/>
          </section>
        </section>
        <section name='Log fetched user'>
          <uncaught_exception>
            <verdict_id>With ExampleRestClient</verdict_id>
            <class>NameError</class>
            <message>
              undefined local variable or method `user&apos; for
              #&lt;DataLogComplexTest:0x3ad4c60&gt;
            </message>
            <backtrace>
              <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:11:in `prelude']]>
            </backtrace>
          </uncaught_exception>
        </section>
      </section>
      <section name='Count of errors (unexpected exceptions)'>
        <verdict id='error count' message='error count' method='verdict_assert_equal?' outcome='failed' volatile='true'>
          <exp_value>0</exp_value>
          <act_value>1</act_value>
          <exception>
            <class>Minitest::Assertion</class>
            <message>Expected: 0 Actual: 1</message>
            <backtrace>
              <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:11:in `prelude']]>
            </backtrace>
          </exception>
        </verdict>
      </section>
    </section>
  </test_method>
</data_log_complex_test>
```

**Prev** [Logging a Simple Data Object](./DataLogSimple.md)

**Next** [Creating a Simple Data Object](./DataNewSimple.md)

