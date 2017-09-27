<!--- GENERATED FILE, DO NOT EDIT --->
[Prev](./DataNewComplex.md) [Next](./DataEqualComplex.md)

# Simple Data Object Equality

## Test Source Code

<code>data_equal_simple_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../../rest_api/data/album'

class DataEqualTest < BaseClassForTest

  def test_data_equal_simple
    prelude do |client, log|
      album_0 = Album.get_first(client)
      album_1 = Album.deep_clone(album_0)
      log.section('These are equal') do
        fail unless Album.equal?(album_0, album_1)
        Album.verdict_equal?(log, 'album equal', album_0, album_1, 'Using Album.verdict_equal?')
      end
      log.section('These are not equal') do
        album_1.id += 1
        fail if Album.equal?(album_0, album_1)
        Album.verdict_equal?(log, 'album not equal', album_0, album_1, 'Using Album.verdict_equal?')
      end
    end
  end

end
```

Notes:

- The test gets a known Album, then clones it.
- We know that Album is flat, but it's good practice to use <code>deep_clone</code>, not <code>clone</code> just to be sure.
- In the first section:
  - Method <code>Album.equal?</code> returns <code>true</code>, but does no logging.
  - The <code>fail unless</code> proves that it worked.
  - Method <code>Album.verdict_equal?</code> verifies and logs each value in the albums.
- In the second section:
  - One value in the album is modified.
  - Method <code>Album.equal?</code> returns <code>false</code>, but does no logging.
  - The <code>fail if </code> proves that it worked.
  - Method <code>Album.verdict_equal?</code> verifies and logs each value in the albums.

##  Test Log

<code>test_data_equal_simple.xml</code>
```xml
<data_equal_simple_test>
  <summary errors='0' failures='1' verdicts='7'/>
  <test_method duration_seconds='1.506' name='data_equal_simple_test' timestamp='2017-09-27-Wed-15.13.17.676'>
    <section name='With ExampleRestClient'>
      <section duration_seconds='0.000' method='GET' name='Rest client' timestamp='2017-09-27-Wed-15.13.17.680' url='https://jsonplaceholder.typicode.com/albums'>
        <parameters/>
      </section>
      <section name='These are equal'>
        <verdict id='album equal-id' message='Using Album.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>1</exp_value>
          <act_value>1</act_value>
        </verdict>
        <verdict id='album equal-userid' message='Using Album.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>1</exp_value>
          <act_value>1</act_value>
        </verdict>
        <verdict id='album equal-title' message='Using Album.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>quidem molestiae enim</exp_value>
          <act_value>quidem molestiae enim</act_value>
        </verdict>
      </section>
      <section name='These are not equal'>
        <verdict id='album not equal-id' message='Using Album.verdict_equal?' method='verdict_assert_equal?' outcome='failed' volatile='false'>
          <exp_value>1</exp_value>
          <act_value>2</act_value>
          <exception>
            <class>Minitest::Assertion</class>
            <message>Expected: 1 Actual: 2</message>
            <backtrace>
              <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:129:in `block in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:118:in `verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:44:in `verdict_equal?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/data_equal_simple_test.rb:18:in `block (2 levels) in test_data_equal_simple'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/data_equal_simple_test.rb:15:in `block in test_data_equal_simple'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/data_equal_simple_test.rb:8:in `test_data_equal_simple']]>
            </backtrace>
          </exception>
        </verdict>
        <verdict id='album not equal-userid' message='Using Album.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>1</exp_value>
          <act_value>1</act_value>
        </verdict>
        <verdict id='album not equal-title' message='Using Album.verdict_equal?' method='verdict_assert_equal?' outcome='passed' volatile='false'>
          <exp_value>quidem molestiae enim</exp_value>
          <act_value>quidem molestiae enim</act_value>
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
</data_equal_simple_test>
```

Notes:

- In the first section, all verdicts pass.
- In the second section, one verdict fails.

[Prev](./DataNewComplex.md) [Next](./DataEqualComplex.md)
