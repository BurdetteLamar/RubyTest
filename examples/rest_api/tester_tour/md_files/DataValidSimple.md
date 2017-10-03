<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Verifying a Complex Data Object](./DataEqualComplex.md)

**Next Stop:** [Test for GET Albums](./GetAlbums.md)


# Validating a Simple Data Object

## Example Test

<code>data_valid_simple_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../../rest_api/data/album'

class DataValidTest < BaseClassForTest

  def test_data_valid_simple
    prelude do |_, log|
      log.section('This is valid') do
        album = Album.new(
            :id => Album.valid_id,
            :userId => Album.valid_user_id,
            :title => Album.valid_title,
        )
        album.verdict_valid?(log, 'album valid')
      end
      log.section('This is not valid') do
        album = Album.new(
            :id => Album.invalid_id,
            :userId => Album.invalid_user_id,
            :title => Album.invalid_title,
        )
        album.verdict_valid?(log, 'album not valid')
      end
    end
  end

end
```

Notes:

- In the first section:
  - A new album with valid values is instantiated.
  - The valid values are not in the test itself, but instead come from the data class.
  - Method `Album.verdict_valid? validates and logs each value in the album.
- In the second section:
  - A new album with invalid values is instantiated.
  - The invalid values are not in the test itself, but instead come from the data class.
  - Method `Album.verdict_valid? validates and logs each value in the album.

## Log

<code>test_data_valid_simple.xml</code>
```xml
<data_valid_simple_test>
  <summary errors='0' failures='3' verdicts='13'/>
  <test_method duration_seconds='0.014' name='data_valid_simple_test' timestamp='2017-10-03-Tue-12.29.07.393'>
    <section name='With ExampleRestClient'>
      <section name='This is valid'>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='album valid id - integer' message='id positive integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Fixnum</exp_value>
            <act_value>1</act_value>
          </verdict>
          <verdict id='album valid id - positive' message='id positive integer' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>1</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='album valid userId - integer' message='userId positive integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Fixnum</exp_value>
            <act_value>1</act_value>
          </verdict>
          <verdict id='album valid userId - positive' message='userId positive integer' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>1</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <section name='verdict_assert_string_not_empty?'>
          <verdict id='album valid title - string' message='title nonempty string' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>String</exp_value>
            <act_value>x</act_value>
          </verdict>
          <verdict id='album valid title - not empty' message='title nonempty string' method='verdict_refute_empty?' outcome='passed' volatile='false'>
            <act_value>x</act_value>
          </verdict>
        </section>
      </section>
      <section name='This is not valid'>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='album not valid id - integer' message='id positive integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Fixnum</exp_value>
            <act_value>0</act_value>
          </verdict>
          <verdict id='album not valid id - positive' message='id positive integer' method='verdict_assert_operator?' outcome='failed' volatile='false'>
            <object_1>0</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
            <exception>
              <class>Minitest::Assertion</class>
              <message>Expected 0 to be &gt; 0.</message>
              <backtrace>
                <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/data/album.rb:34:in `verdict_field_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:36:in `block in verdict_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:35:in `verdict_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/data_valid_simple_test.rb:23:in `block (2 levels) in test_data_valid_simple'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/data_valid_simple_test.rb:17:in `block in test_data_valid_simple'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/data_valid_simple_test.rb:8:in `test_data_valid_simple']]>
              </backtrace>
            </exception>
          </verdict>
        </section>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='album not valid userId - integer' message='userId positive integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Fixnum</exp_value>
            <act_value>0</act_value>
          </verdict>
          <verdict id='album not valid userId - positive' message='userId positive integer' method='verdict_assert_operator?' outcome='failed' volatile='false'>
            <object_1>0</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
            <exception>
              <class>Minitest::Assertion</class>
              <message>Expected 0 to be &gt; 0.</message>
              <backtrace>
                <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/data/album.rb:34:in `verdict_field_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:36:in `block in verdict_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:35:in `verdict_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/data_valid_simple_test.rb:23:in `block (2 levels) in test_data_valid_simple'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/data_valid_simple_test.rb:17:in `block in test_data_valid_simple'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/data_valid_simple_test.rb:8:in `test_data_valid_simple']]>
              </backtrace>
            </exception>
          </verdict>
        </section>
        <section name='verdict_assert_string_not_empty?'>
          <verdict id='album not valid title - string' message='title nonempty string' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>String</exp_value>
            <act_value/>
          </verdict>
          <verdict id='album not valid title - not empty' message='title nonempty string' method='verdict_refute_empty?' outcome='failed' volatile='false'>
            <act_value/>
            <exception>
              <class>Minitest::Assertion</class>
              <message>Expected # encoding: UTF-8 &quot;&quot; to not be empty.</message>
              <backtrace>
                <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/data/album.rb:39:in `verdict_field_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:36:in `block in verdict_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:35:in `verdict_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/data_valid_simple_test.rb:23:in `block (2 levels) in test_data_valid_simple'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/data_valid_simple_test.rb:17:in `block in test_data_valid_simple'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/data_valid_simple_test.rb:8:in `test_data_valid_simple']]>
              </backtrace>
            </exception>
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
</data_valid_simple_test>
```

Notes:

- In the first section, all verdicts pass.
- When a value has multiple validation verdicts (as all of these do), the verdicts are logged into a separate subsection.
- In the second section, three verdicts fail.

**Prev Stop:** [Verifying a Complex Data Object](./DataEqualComplex.md)

**Next Stop:** [Test for GET Albums](./GetAlbums.md)

