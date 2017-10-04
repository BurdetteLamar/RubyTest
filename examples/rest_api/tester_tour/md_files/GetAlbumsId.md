<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Test for GET Albums](./GetAlbums.md)

**Next Stop:** [Test for DELETE Albums/_id_](./DeleteAlbumsId.md)


# Test for GET Albums/_id_

This page shows how to test GET Albums/_id_.

## Example Test

<code>get_albums_id_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/albums/get_albums_id'

class GetAlbumsIdTest < BaseClassForTest

  def test_get_albums_id
    prelude do |client, log|
      log.section('Test endpoint GET albums/id') do
        album_to_get = nil
        log.section('Fetch an album to GET') do
          album_to_get = Album.get_first(client)
          log.section('Album fetched') do
            album_to_get.log(log)
          end
        end
        log.section('GET the album') do
          verdict_id = 'GET album'
          GetAlbumsId.verdict_call_and_verify_success(client, log, verdict_id, album_to_get)
        end
      end
    end
  end

end
```

Notes:

- Method `Album.get_first` is a convenience method that fetches the first album as an `Album` object.
- Method `GetAlbumsId.verdict_call_and_verify_success`:
  1.  Accesses endpoint GET albums/_id_, using field `:id` from the given album `album_to_get`.
  2.  Forms the response payload into a new `Album` object, `album_fetched`.
  3.  Verifies that the values in `album_to_get` are equal to those in `album_fetched`.

## Log

<code>test_get_albums_id.xml</code>
```xml
<get_albums_id_test>
  <summary errors='0' failures='0' verdicts='4'/>
  <test_method name='get_albums_id_test' timestamp='2017-10-04-Wed-12.44.36.418'>
    <section duration_seconds='1.620' name='With ExampleRestClient'>
      <section name='Test endpoint GET albums/id'>
        <section name='Fetch an album to GET'>
          <REST_API method='GET' url='https://jsonplaceholder.typicode.com/albums'>
            <execution duration_seconds='1.544' timestamp='2017-10-04-Wed-12.44.36.421'/>
          </REST_API>
          <section name='Album fetched'>
            <section name='Album'>
              <data field='id' value='1'/>
              <data field='userId' value='1'/>
              <data field='title' value='quidem molestiae enim'/>
            </section>
          </section>
        </section>
        <section name='GET the album'>
          <section name='GET album' timestamp='2017-10-04-Wed-12.44.37.973'>
            <REST_API method='GET' url='https://jsonplaceholder.typicode.com/albums/1'>
              <execution duration_seconds='0.062' timestamp='2017-10-04-Wed-12.44.37.973'/>
            </REST_API>
            <section name='Evaluation'>
              <verdict id='Album-id' message='Got' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>1</exp_value>
                <act_value>1</act_value>
              </verdict>
              <verdict id='Album-userid' message='Got' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>1</exp_value>
                <act_value>1</act_value>
              </verdict>
              <verdict id='Album-title' message='Got' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>quidem molestiae enim</exp_value>
                <act_value>quidem molestiae enim</act_value>
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
</get_albums_id_test>
```

**Prev Stop:** [Test for GET Albums](./GetAlbums.md)

**Next Stop:** [Test for DELETE Albums/_id_](./DeleteAlbumsId.md)

