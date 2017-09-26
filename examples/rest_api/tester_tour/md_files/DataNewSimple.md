<!--- GENERATED FILE, DO NOT EDIT --->
[Prev](./PostAlbums.md) [Next](./DataNewComplex.md)

# Creating a Data Object

This page introduces simple data classes, and shows how to create instances of them.

## Test Source Code

<code>data_new_simple_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../../rest_api/data/album'
require_relative '../../../rest_api/data/user'

class DataNewTest < BaseClassForTest

  def test_data_new_simple
    prelude do |_, log|
      log.section('Create and log an instance of Album') do
        album = Album.new(
            :id => nil,
            :userId => 1,
            :title => 'My album title',
        )
        log.section('Created album') do
          album.log(log)
        end
      end
    end
  end

end
```

Notes:

- The JSONPlaceholder REST API has several resources, including the Album resource.  That resource is represented in this test framework by class <code>Album</code>.
- The Album resource and its corresponding class are flat, each consisting of only three scalar values, seen here in the call to <code>Album.new</code>.
- These values are passed to method <code>Album.new</code> in a hash that gives the names and values.
- Note that the created album exists only here in the test, and not in the REST API itself.  If it were created in the API, it would be assigned a non-nil <code>:id</code> value.
- Class <code>Album</code> derives from base classes that provide it with the ability to log itself, as seen here in the call to method <code>album.log</code.
- This is true of all data objects in the framework.

##  Test Log

<code>test_data_new_simple.xml</code>
```xml
<data_new_simple_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='0.002' name='data_new_simple_test' timestamp='2017-09-25-Mon-19.54.33.413'>
    <section name='With ExampleRestClient'>
      <section name='Create and log an instance of Album'>
        <section name='Created album'>
          <data field='userId' value='1'/>
          <data field='title' value='My album title'/>
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
</data_new_simple_test>
```

[Prev](./PostAlbums.md) [Next](./DataNewComplex.md)
