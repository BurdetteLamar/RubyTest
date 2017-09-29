<!--- GENERATED FILE, DO NOT EDIT --->
**Prev** [Exceptions, Rescued and Not](./Exceptions.md)

**Next** [Logging a Complex Data Object](./DataLogComplex.md)


# Logging a Simple Data Object

This page introduces simple data classes, and shows how to log instances of them.

## Example Test

<code>data_log_simple_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../../rest_api/data/album'

class DataNewTest < BaseClassForTest

  def test_data_log_simple
    prelude do |client, log|
      log.section('Fetch and log an instance of Album') do
        log.section('Fetch an album') do
          album = Album.get_first(client)
        end
        log.section('Log fetched album') do
          album.log(log)
        end
      end
    end
  end

end
```

Notes:

- The JSONPlaceholder REST API has several resources, including the Album resource.  That resource is represented in this test framework by class <code>Album</code>.
- Because this test uses albums, it requires the album class.
- Class <code>Album</code> derives from base classes that provide it with the ability to log itself, as seen here in the call to method <code>album.log</code>.
- This is true of all data objects in the framework.

## Log

<code>test_data_log_simple.xml</code>
```xml
<data_log_simple_test>
  <summary errors='1' failures='1' verdicts='1'/>
  <test_method name='data_log_simple_test' timestamp='2017-09-29-Fri-12.41.26.443'>
    <section name='With ExampleRestClient'>
      <section duration_seconds='1.580' name='Fetch and log an instance of Album'>
        <section name='Fetch an album'>
          <section duration_seconds='0.000' method='GET' name='Rest client' timestamp='2017-09-29-Fri-12.41.26.448' url='https://jsonplaceholder.typicode.com/albums'>
            <parameters/>
          </section>
        </section>
        <section name='Log fetched album'>
          <uncaught_exception>
            <verdict_id>With ExampleRestClient</verdict_id>
            <class>NameError</class>
            <message>
              undefined local variable or method `album&apos; for
              #&lt;DataNewTest:0x3a4d150&gt;
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
</data_log_simple_test>
```

**Prev** [Exceptions, Rescued and Not](./Exceptions.md)

**Next** [Logging a Complex Data Object](./DataLogComplex.md)

