# GetAlbumsIdTest

## Test Source Code

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

- Nested log sections help organize both the test source code and the test log.
- Method <code>Album.get_first</code> is a convenience method that fetches the first album as an <code>Album</object>.
- Variable <code>verdict_id</code> is a verdict identifier that must be unique within the test method.
- Method <code>GetAlbumsId.verdict_call_and_verify_success</code> interacts with the REST API and logs information:
  1.  Does <code>GET albums/</code><i>id</i>, using field <code>:id</code> from the given album <code>album_to_get</code>.
  2.  Forms the response payload into a new <code>Album</code> object, <code>album_fetched</code>.
  3.  Verifies that the values in <code>album_to_get</code> are equal to those in <code>album_fetched</code>.

##  Test Log

<code>test_get_albums_id.xml</code>
```xml
<get_albums_id_test>
  <summary errors='0' failures='0' verdicts='4'/>
  <test_method name='get_albums_id_test' timestamp='2017-09-21-Thu-12.02.15.678'>
    <section duration_seconds='7.403' name='With ExampleRestClient'>
      <section name='Test endpoint GET albums/id'>
        <section name='Fetch an album to GET'>
          <section duration_seconds='0.000' method='GET' name='Rest client' timestamp='2017-09-21-Thu-12.02.15.682' url='https://jsonplaceholder.typicode.com/albums'>
            <parameters/>
          </section>
          <section name='Album fetched'>
            <data field='id' value='1'/>
            <data field='userId' value='1'/>
            <data field='title' value='quidem molestiae enim'/>
          </section>
        </section>
        <section name='GET the album'>
          <section name='GET album' timestamp='2017-09-21-Thu-12.02.22.972'>
            <section duration_seconds='0.000' method='GET' name='Rest client' timestamp='2017-09-21-Thu-12.02.22.972' url='https://jsonplaceholder.typicode.com/albums/1'>
              <parameters/>
            </section>
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
    <verdict id='error count' message='error count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>0</act_value>
    </verdict>
  </test_method>
</get_albums_id_test>
```

Notes:

- The <code>section</code> elements organize the log.
- Each <code>section</code> element whose <code>name</code> is <code>Rest client</code> records an interaction with the REST API, including any passed parameters.
- Each <code>verdict</code> element contains a verification.
- The <code>section</code> whose <code>name</code> is <code>Evaluation</code> contains verdicts about the returned data.
