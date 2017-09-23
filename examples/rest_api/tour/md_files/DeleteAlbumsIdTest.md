# DeleteAlbumsIdTest

## Test Source Code

<code>delete_albums_id_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/albums/delete_albums_id'

class DeleteAlbumsIdTest < BaseClassForTest

  def test_delete_albums_id

    prelude do |client, log|

      log.section('Test endpoint DELETE albums/id') do

        album_to_delete = nil
        log.section('Fetch an album to DELETE') do
          album_to_delete = Album.get_first(client)
          log.section('Album fetched') do
            album_to_delete.log(log)
          end
        end

        log.section('DELETE the album') do
          verdict_id = 'DELETE album'
          DeleteAlbumsId.verdict_call_and_verify_success(client, log, verdict_id, album_to_delete)
        end

      end

    end
  end
end
```

Notes:

- Nested log sections help organize both the test source code and the test log.
- Method <code>Album.get_first</code> is a convenience method that fetches the first album as an <code>Album</object>.
- Variable <code>verdict_id</code> is a verdict identifier that must be unique within the test method.
- Method <code>DeleteAlbumsId.verdict_call_and_verify_success</code> interacts with the REST API and logs information:
  1.  Does <code>DELETE albums/,id</code><i>id</i>, using field <code>:id</code> from the given album <code>album_to_delete</code>.
  2.  Verifies that the return had no payload.
  3.  Verifies that the album no longer exists.

##  Test Log

<code>test_delete_albums_id.xml</code>
```xml
<delete_albums_id_test>
  <summary errors='0' failures='1' verdicts='3'/>
  <test_method name='delete_albums_id_test' timestamp='2017-09-22-Fri-09.40.12.385'>
    <section duration_seconds='2.104' name='With ExampleRestClient'>
      <section name='Test endpoint DELETE albums/id'>
        <section name='Fetch an album to DELETE'>
          <section duration_seconds='0.000' method='GET' name='Rest client' timestamp='2017-09-22-Fri-09.40.12.389' url='https://jsonplaceholder.typicode.com/albums'>
            <parameters/>
          </section>
          <section name='Album fetched'>
            <data field='id' value='1'/>
            <data field='userId' value='1'/>
            <data field='title' value='quidem molestiae enim'/>
          </section>
        </section>
        <section name='DELETE the album'>
          <section name='DELETE album' timestamp='2017-09-22-Fri-09.40.13.868'>
            <section duration_seconds='0.000' method='DELETE' name='Rest client' timestamp='2017-09-22-Fri-09.40.13.869' url='https://jsonplaceholder.typicode.com/albums/1'>
              <parameters/>
            </section>
            <section name='Evaluation'>
              <verdict id='payload nil' message='Payload nil' method='verdict_assert_nil?' outcome='passed' volatile='false'>
                <act_value>nil</act_value>
              </verdict>
              <section duration_seconds='0.000' method='GET' name='Rest client' timestamp='2017-09-22-Fri-09.40.14.349' url='https://jsonplaceholder.typicode.com/albums/1'>
                <parameters/>
              </section>
              <verdict id='DELETE album' message='Album not exist' method='verdict_refute?' outcome='failed' volatile='false'>
                <act_value>true</act_value>
                <exception>
                  <class>Minitest::Assertion</class>
                  <message>Expected true to not be truthy.</message>
                  <backtrace>
                    <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_resource.rb:25:in `verdict_not_exist?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/endpoints/base_class_for_delete_id.rb:21:in `block (2 levels) in verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/endpoints/base_class_for_delete_id.rb:18:in `block in verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/endpoints/base_class_for_delete_id.rb:16:in `verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/endpoints/albums/delete_albums_id.rb:14:in `verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tour/tests/delete_albums_id_test.rb:23:in `block (3 levels) in test_delete_albums_id'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tour/tests/delete_albums_id_test.rb:21:in `block (2 levels) in test_delete_albums_id'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tour/tests/delete_albums_id_test.rb:11:in `block in test_delete_albums_id'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tour/tests/delete_albums_id_test.rb:9:in `test_delete_albums_id']]>
                  </backtrace>
                </exception>
              </verdict>
            </section>
          </section>
        </section>
      </section>
    </section>
    <verdict id='error count' message='error count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>0</act_value>
    </verdict>
  </test_method>
</delete_albums_id_test>
```

Notes:

- The <code>section</code> elements organize the log.
- Each <code>section</code> element whose <code>name</code> is <code>Rest client</code> records an interaction with the REST API, including any passed parameters.
- Each <code>verdict</code> element contains a verification.
- The <code>section</code> whose <code>name</code> is <code>Evaluation</code> contains verdicts about the returned data.
- The verdict that confirms the deletion fails, because the JSONPlaceholder REST API does not really delete the album.  That is intentional, and documented at the website.
- For the failed verdict, the log reports the exception, including the message and backtrace.