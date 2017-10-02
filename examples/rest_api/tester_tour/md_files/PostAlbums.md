<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop** [Test for PUT Albums/_id_](./PutAlbumsId.md)

**Next Stop** [More to Come ...](./MoreToCome.md)


# Test for POST Albums

This page shows how to test POST Albums.

## Example Test

<code>post_albums_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/albums/post_albums'

class PostAlbumsTest < BaseClassForTest

  def test_post_albums
    prelude do |client, log|
      log.section('Test endpoint POST albums') do
        album_to_post = nil
        log.section('Album to post') do
          album_to_post = Album.get_first(client)
          album_to_post.title = 'My album title'
          album_to_post.log(log)
        end
        log.section('POST the album') do
          verdict_id = 'POST album'
          PostAlbums.verdict_call_and_verify_success(client, log, verdict_id, album_to_post)
        end
      end
    end
  end

end
```

Notes:

- The test creates a new Album object `album_to_post`.
- Method `PostAlbums.verdict_call_and_verify_success`:
  1.  Accesses endpoint POST albums, using parameter values from `album_to_post`.
  2.  Forms the returned payload into a new Album object, `album_posted`.
  3.  Verifies that `album_posted` matches `album_to_post`.
  4.  Fetches the album as `album_fetched`, using the id from `album_posted`.
  5.  Verifies that `album_fetched` matches `album_posted`.

## Log

<code>test_post_albums.xml</code>
```xml
<post_albums_test>
  <summary errors='0' failures='1' verdicts='7'/>
  <test_method name='post_albums_test' timestamp='2017-10-02-Mon-16.26.21.649'>
    <section duration_seconds='1.903' name='With ExampleRestClient'>
      <section name='Test endpoint POST albums'>
        <section name='Album to post'>
          <REST_API method='GET' url='https://jsonplaceholder.typicode.com/albums'>
            <execution duration_seconds='1.544' timestamp='2017-10-02-Mon-16.26.21.653'/>
          </REST_API>
          <section name='Album'>
            <data field='id' value='1'/>
            <data field='userId' value='1'/>
            <data field='title' value='My album title'/>
          </section>
        </section>
        <section name='POST the album'>
          <section name='POST album' timestamp='2017-10-02-Mon-16.26.23.197'>
            <REST_API method='POST' url='https://jsonplaceholder.typicode.com/albums'>
              <parameters id='1' title='My album title' userId='1'/>
              <execution duration_seconds='0.212' timestamp='2017-10-02-Mon-16.26.23.197'/>
            </REST_API>
            <section name='Evaluation'>
              <verdict id='Album posted-id' message='Posted' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>1</exp_value>
                <act_value>1</act_value>
              </verdict>
              <verdict id='Album posted-userid' message='Posted' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>1</exp_value>
                <act_value>1</act_value>
              </verdict>
              <verdict id='Album posted-title' message='Posted' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>My album title</exp_value>
                <act_value>My album title</act_value>
              </verdict>
              <REST_API method='GET' url='https://jsonplaceholder.typicode.com/albums/1'>
                <execution duration_seconds='0.068' timestamp='2017-10-02-Mon-16.26.23.417'/>
              </REST_API>
              <verdict id='Album fetched-id' message='Fetched' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>1</exp_value>
                <act_value>1</act_value>
              </verdict>
              <verdict id='Album fetched-userid' message='Fetched' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>1</exp_value>
                <act_value>1</act_value>
              </verdict>
              <verdict id='Album fetched-title' message='Fetched' method='verdict_assert_equal?' outcome='failed' volatile='false'>
                <exp_value>My album title</exp_value>
                <act_value>quidem molestiae enim</act_value>
                <exception>
                  <class>Minitest::Assertion</class>
                  <message>
                    --- expected +++ actual @@ -1,2 +1,2 @@ # encoding: UTF-8
                    -&quot;My album title&quot; +&quot;quidem molestiae
                    enim&quot;
                  </message>
                  <backtrace>
                    <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:131:in `block in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:120:in `verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:46:in `verdict_equal?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/endpoints/base_class_for_post.rb:24:in `block (2 levels) in verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/endpoints/base_class_for_post.rb:20:in `block in verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/endpoints/base_class_for_post.rb:18:in `verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/endpoints/albums/post_albums.rb:14:in `verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/post_albums_test.rb:18:in `block (3 levels) in test_post_albums'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/post_albums_test.rb:16:in `block (2 levels) in test_post_albums'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/post_albums_test.rb:9:in `block in test_post_albums'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/post_albums_test.rb:8:in `test_post_albums']]>
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
</post_albums_test>
```

Notes:

- The fetched album does not match the posted album, because JSONPlaceholder does not really create the album.  That is intentional, and is documented at the website.

**Prev Stop** [Test for PUT Albums/_id_](./PutAlbumsId.md)

**Next Stop** [More to Come ...](./MoreToCome.md)

