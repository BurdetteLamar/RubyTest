<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Validating a Simple Data Object](./DataValidSimple.md)

**Next Stop:** [Test for GET Albums/_id_](./GetAlbumsId.md)


# Test for GET Albums

This page shows how to test GET Albums.

## Example Test

<code>get_albums_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/albums/get_albums'

class GetAlbumsTest < BaseClassForTest

  def test_get_albums
    prelude do |client, log|
      log.section('Test endpoint GET albums') do
        log.section('GET albums') do
          verdict_id = 'GET albums'
          GetAlbums.verdict_call_and_verify_success(client, log, verdict_id)
        end
      end
    end
  end

end
```

Notes:

- This test uses an endpoint, and therefore requires the corresponding class.
- Method `GetAlbums.verdict_call_and_verify_success`:
  1.  Accesses endpoint GET albums.
  2.  Forms the response payload into new `Album` objects.
  3.  Logs the count of returned albums.
  4.  Logs the content of the first album.
  5.  Verifies that each the value in the first album is valid (i.e., has the expected form).

## Log

<code>test_get_albums.xml</code>
```xml
<get_albums_test>
  <summary errors='2' failures='1' verdicts='7'/>
  <test_method name='get_albums_test' timestamp='2017-10-03-Tue-17.07.26.810'>
    <section name='With ExampleRestClient'>
      <section name='Test endpoint GET albums'>
        <section duration_seconds='1.538' name='GET albums'>
          <section name='GET albums' timestamp='2017-10-03-Tue-17.07.26.811'>
            <REST_API method='GET' url='https://jsonplaceholder.typicode.com/albums'>
              <execution duration_seconds='1.513' timestamp='2017-10-03-Tue-17.07.26.811'/>
            </REST_API>
            <section duration_seconds='1.535' name='Evaluation'>
              <data fetched_object_count='100'/>
              <section name='First fetched'>
                <section name='Album'>
                  <data field='id' value='1'/>
                  <data field='userId' value='1'/>
                  <data field='title' value='quidem molestiae enim'/>
                </section>
              </section>
              <section name='verdict_assert_integer_positive?'>
                <verdict id='GET albums id - integer' message='id positive integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                  <exp_value>Fixnum</exp_value>
                  <act_value>1</act_value>
                </verdict>
                <verdict id='GET albums id - positive' message='id positive integer' method='verdict_assert_operator?' outcome='passed' volatile='false'>
                  <object_1>1</object_1>
                  <operator>:&gt;</operator>
                  <object_2>0</object_2>
                </verdict>
              </section>
              <section name='verdict_assert_integer_positive?'>
                <verdict id='GET albums userId - integer' message='userId positive integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                  <exp_value>Fixnum</exp_value>
                  <act_value>1</act_value>
                </verdict>
                <verdict id='GET albums userId - positive' message='userId positive integer' method='verdict_assert_operator?' outcome='passed' volatile='false'>
                  <object_1>1</object_1>
                  <operator>:&gt;</operator>
                  <object_2>0</object_2>
                </verdict>
              </section>
              <section name='verdict_assert_string_length_in_range?'>
                <verdict id='GET albums title - string' message='title length in range' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                  <exp_value>String</exp_value>
                  <act_value>quidem molestiae enim</act_value>
                </verdict>
                <section name='Value in range'>
                  <exp_range>1..50</exp_range>
                  <act_value>21</act_value>
                  <verdict id='GET albums title - in range' message='title length in range' method='verdict_assert?' outcome='passed' volatile='false'>
                    <act_value>true</act_value>
                  </verdict>
                </section>
              </section>
              <uncaught_exception>
                <verdict_id>GET albums</verdict_id>
                <class>ReturnContractError</class>
                <message>
                  Contract violation for return value: Expected: Bool, Actual:
                  nil Value guarded in: Album::verdict_field_valid? With
                  Contract: Log, String, Symbol =&gt; Bool At:
                  c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/data/album.rb:26 
                </message>
                <backtrace>
                  <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:36:in `block in verdict_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:35:in `verdict_valid?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/endpoints/base_class_for_get.rb:28:in `block (2 levels) in verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/endpoints/base_class_for_get.rb:22:in `block in verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/endpoints/base_class_for_get.rb:20:in `verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/endpoints/albums/get_albums.rb:14:in `verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/get_albums_test.rb:12:in `block (3 levels) in test_get_albums'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/get_albums_test.rb:10:in `block (2 levels) in test_get_albums'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/get_albums_test.rb:9:in `block in test_get_albums'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/get_albums_test.rb:8:in `test_get_albums']]>
                </backtrace>
              </uncaught_exception>
            </section>
            <uncaught_exception>
              <verdict_id>With ExampleRestClient</verdict_id>
              <class>ReturnContractError</class>
              <message>
                Contract violation for return value: Expected: (a collection
                Array of Album), Actual: nil Value guarded in:
                GetAlbums::verdict_call_and_verify_success With Contract:
                ExampleRestClient, Log, String, Maybe =&gt; CollectionOf At:
                c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/endpoints/albums/get_albums.rb:13 
              </message>
              <backtrace>
                <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/get_albums_test.rb:12:in `block (3 levels) in test_get_albums'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/get_albums_test.rb:10:in `block (2 levels) in test_get_albums'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/get_albums_test.rb:9:in `block in test_get_albums'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/get_albums_test.rb:8:in `test_get_albums']]>
              </backtrace>
            </uncaught_exception>
          </section>
        </section>
        <section name='Count of errors (unexpected exceptions)'>
          <verdict id='error count' message='error count' method='verdict_assert_equal?' outcome='failed' volatile='true'>
            <exp_value>0</exp_value>
            <act_value>2</act_value>
            <exception>
              <class>Minitest::Assertion</class>
              <message>Expected: 0 Actual: 2</message>
              <backtrace>
                <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/get_albums_test.rb:8:in `test_get_albums']]>
              </backtrace>
            </exception>
          </verdict>
        </section>
      </section>
    </section>
  </test_method>
</get_albums_test>
```

Notes:

- Each `section` element whose `name` is `Rest client` records an interaction with the REST API, including any passed parameters.
- The `section` whose `name` is `Evaluation` contains verdicts about the returned data.

**Prev Stop:** [Validating a Simple Data Object](./DataValidSimple.md)

**Next Stop:** [Test for GET Albums/_id_](./GetAlbumsId.md)

