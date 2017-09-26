<!--- GENERATED FILE, DO NOT EDIT --->
[Prev](./DeleteAlbumsId.md) [Next](./PostAlbums.md)

# Test for PUT Albums/_id_

This page shows how to test PUT Albums/_id_.

## Test Source Code

<code>put_albums_id_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/albums/get_albums'
require_relative '../../endpoints/albums/put_albums_id'

class PutAlbumsIdTest < BaseClassForTest

  def test_put_albums_id
    prelude do |client, log|
      log.section('Test endpoint PUT albums/id') do
        album_to_put = nil
        log.section('Make a modified album') do
          album_to_put = Album.get_first(client)
          album_to_put.title = 'My new title'
          log.section('Album to put') do
            album_to_put.log(log)
          end
        end
        log.section('PUT the album') do
          verdict_id = 'PUT album'
          PutAlbumsId.verdict_call_and_verify_success(client, log, verdict_id, album_to_put)
        end
      end
    end
  end

end
```

Notes:

- Method <code>Album.get_first</code> is a convenience method that fetches the first album as an <code>Album</object>.  It is modified and becomes <album_to_put>.
- Method <code>PutAlbumsId.verdict_call_and_verify_success</code>:
  1.  Accesses endpoint PUT albums/_id_, using field <code>:id</code> from <code>album_to_put</code>.
  2.  Forms the response payload into a new Album object, <code>album_put</code>.
  3.  Verifies that the values in <code>album_put</code> are equal to those in <code>album_to_put</code>.
  4.  Fetches the updated album <code>album_fetched</code>, using parameters from <code>album_put</code>.
  4.  Verifies that the values in <code>album_put</code> are equal to those in <code>album_fetched</code>.

##  Test Log

<code>test_put_albums_id.xml</code>
```xml
<put_albums_id_test>
  <summary errors='0' failures='1' verdicts='7'/>
  <test_method name='put_albums_id_test' timestamp='2017-09-25-Mon-19.50.14.553'>
    <section duration_seconds='1.953' name='With ExampleRestClient'>
      <section name='Test endpoint PUT albums/id'>
        <section name='Make a modified album'>
          <section duration_seconds='0.000' method='GET' name='Rest client' timestamp='2017-09-25-Mon-19.50.14.563' url='https://jsonplaceholder.typicode.com/albums'>
            <parameters/>
          </section>
          <section name='Album to put'>
            <data field='id' value='1'/>
            <data field='userId' value='1'/>
            <data field='title' value='My new title'/>
          </section>
        </section>
        <section name='PUT the album'>
          <section name='PUT album' timestamp='2017-09-25-Mon-19.50.16.078'>
            <section duration_seconds='0.000' method='PUT' name='Rest client' timestamp='2017-09-25-Mon-19.50.16.079' url='https://jsonplaceholder.typicode.com/albums/1'>
              <parameters id='1' title='My new title' userId='1'/>
            </section>
            <section name='Evaluation'>
              <verdict id='Put-id' message='Put' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>1</exp_value>
                <act_value>1</act_value>
              </verdict>
              <verdict id='Put-userid' message='Put' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>1</exp_value>
                <act_value>1</act_value>
              </verdict>
              <verdict id='Put-title' message='Put' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>My new title</exp_value>
                <act_value>My new title</act_value>
              </verdict>
              <section duration_seconds='0.000' method='GET' name='Rest client' timestamp='2017-09-25-Mon-19.50.16.326' url='https://jsonplaceholder.typicode.com/albums/1'>
                <parameters/>
              </section>
              <verdict id='Fetched-id' message='Fetched' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>1</exp_value>
                <act_value>1</act_value>
              </verdict>
              <verdict id='Fetched-userid' message='Fetched' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>1</exp_value>
                <act_value>1</act_value>
              </verdict>
              <verdict id='Fetched-title' message='Fetched' method='verdict_assert_equal?' outcome='failed' volatile='false'>
                <exp_value>My new title</exp_value>
                <act_value>quidem molestiae enim</act_value>
                <exception>
                  <class>Minitest::Assertion</class>
                  <message>
                    --- expected +++ actual @@ -1,2 +1,2 @@ # encoding: UTF-8
                    -&quot;My new title&quot; +&quot;quidem molestiae enim&quot;
                  </message>
                  <backtrace>
                    <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:127:in `block in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:118:in `verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:44:in `verdict_equal?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/endpoints/base_class_for_put_id.rb:25:in `block (2 levels) in verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/endpoints/base_class_for_put_id.rb:21:in `block in verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/endpoints/base_class_for_put_id.rb:19:in `verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/endpoints/albums/put_albums_id.rb:14:in `verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/put_albums_id_test.rb:21:in `block (3 levels) in test_put_albums_id'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/put_albums_id_test.rb:19:in `block (2 levels) in test_put_albums_id'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/put_albums_id_test.rb:10:in `block in test_put_albums_id'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/put_albums_id_test.rb:9:in `test_put_albums_id']]>
                  </backtrace>
                </exception>
              </verdict>
            </section>
          </section>
        </section>
      </section>
    </section>
    <section name='Count of errors (unexpected exceptions)'>
      <verdict id='error count' message='error count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
        <exp_value>0</exp_value>
        <act_value>0</act_value>
      </verdict>
    </section>
  </test_method>
</put_albums_id_test>
```

- The fetched album does not match the put album, because JSONPlaceholder does not really update the album.  That is intentional, and is documented at the website.
[Prev](./DeleteAlbumsId.md) [Next](./PostAlbums.md)

[Prev](./DeleteAlbumsId.md) [Next](./PostAlbums.md)
