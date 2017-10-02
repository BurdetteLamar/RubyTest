<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop** [Test for GET Albums/_id_](./GetAlbumsId.md)

**Next Stop** [Test for PUT Albums/_id_](./PutAlbumsId.md)


# Test for DELETE Albums/_id_

This page shows how to test DELETE Albums/_id_.

## Example Test

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

- Method `DeleteAlbumsId.verdict_call_and_verify_success`:
  1.  Accesses endpoint DELETE albums/_id_, using field `:id` from the given album `album_to_delete`.
  2.  Verifies that the return had no payload.
  3.  Verifies that the album no longer exists.

## Log

<code>test_delete_albums_id.xml</code>
```xml
<delete_albums_id_test>
  <summary errors='0' failures='1' verdicts='3'/>
  <test_method name='delete_albums_id_test' timestamp='2017-10-02-Mon-11.49.21.695'>
    <section duration_seconds='2.029' name='With ExampleRestClient'>
      <section name='Test endpoint DELETE albums/id'>
        <section name='Fetch an album to DELETE'>
          <REST_API method='GET' url='https://jsonplaceholder.typicode.com/albums'>
            <execution duration_seconds='1.489' timestamp='2017-10-02-Mon-11.49.21.699'/>
          </REST_API>
          <section name='Album fetched'>
            <section name='Album'>
              <data field='id' value='1'/>
              <data field='userId' value='1'/>
              <data field='title' value='quidem molestiae enim'/>
            </section>
          </section>
        </section>
        <section name='DELETE the album'>
          <section name='DELETE album' timestamp='2017-10-02-Mon-11.49.23.188'>
            <REST_API method='DELETE' url='https://jsonplaceholder.typicode.com/albums/1'>
              <execution duration_seconds='0.443' timestamp='2017-10-02-Mon-11.49.23.188'/>
            </REST_API>
            <section name='Evaluation'>
              <verdict id='payload nil' message='Payload nil' method='verdict_assert_nil?' outcome='passed' volatile='false'>
                <act_value>nil</act_value>
              </verdict>
              <REST_API method='GET' url='https://jsonplaceholder.typicode.com/albums/1'>
                <execution duration_seconds='0.091' timestamp='2017-10-02-Mon-11.49.23.631'/>
              </REST_API>
              <verdict id='DELETE album' message='Album not exist' method='verdict_refute?' outcome='failed' volatile='false'>
                <act_value>true</act_value>
                <backtrace>
                  <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_resource.rb:25:in `verdict_not_exist?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/endpoints/base_class_for_delete_id.rb:21:in `block (2 levels) in verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/endpoints/base_class_for_delete_id.rb:18:in `block in verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/endpoints/base_class_for_delete_id.rb:16:in `verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/endpoints/albums/delete_albums_id.rb:14:in `verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/delete_albums_id_test.rb:19:in `block (3 levels) in test_delete_albums_id'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/delete_albums_id_test.rb:17:in `block (2 levels) in test_delete_albums_id'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/delete_albums_id_test.rb:9:in `block in test_delete_albums_id'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tester_tour/tests/delete_albums_id_test.rb:8:in `test_delete_albums_id']]>
                </backtrace>
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
</delete_albums_id_test>
```

Notes:

- The verdict that confirms the deletion fails, because the JSONPlaceholder REST API does not really delete the album.  That is intentional, and is documented at the website.

**Prev Stop** [Test for GET Albums/_id_](./GetAlbumsId.md)

**Next Stop** [Test for PUT Albums/_id_](./PutAlbumsId.md)

