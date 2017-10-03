<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop** [Exceptions, Rescued and Not](./Exceptions.md)

**Next Stop** [Logging a Complex Data Object](./DataLogComplex.md)


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
        album = nil
        log.section('Fetch an album') do
          album = Album.get_first(client)
        end
        album.log(log, 'Fetched album')
      end
    end
  end

end
```

Notes:

- The JSONPlaceholder REST API has several resources, including the Album resource.  That resource is represented in this test framework by class `Album`.
- Class `Album` derives from base classes that provide it with the ability to log itself, as seen here in the call to method `album.log`.

## Log

<code>test_data_log_simple.xml</code>
```xml
<data_log_simple_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='1.540' name='data_log_simple_test' timestamp='2017-10-03-Tue-12.23.54.992'>
    <section name='With ExampleRestClient'>
      <section name='Fetch and log an instance of Album'>
        <section name='Fetch an album'>
          <REST_API method='GET' url='https://jsonplaceholder.typicode.com/albums'>
            <execution duration_seconds='1.529' timestamp='2017-10-03-Tue-12.23.54.997'/>
          </REST_API>
        </section>
        <section name='Fetched album'>
          <data field='id' value='1'/>
          <data field='userId' value='1'/>
          <data field='title' value='quidem molestiae enim'/>
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
</data_log_simple_test>
```

Notes:

- Element `REST_API` records an interaction with the REST API, showing the HTTP method and url.
- Its subelement `execution` shows the timestamp and duration for the interaction.
- The section named `Fetched album` shows the values in the fetched album.

**Prev Stop** [Exceptions, Rescued and Not](./Exceptions.md)

**Next Stop** [Logging a Complex Data Object](./DataLogComplex.md)

