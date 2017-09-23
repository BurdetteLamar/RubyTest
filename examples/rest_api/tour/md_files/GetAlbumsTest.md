# GetAlbumsTest

## Test Source Code

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

- Nested log sections help organize both the test source code and the test log.
- Method <code>GetAlbums.verdict_call_and_verify_success</code> interacts with the REST API and logs information:
  1.  Does <code>GET albums</code>.
  2.  Forms the response payload into new <code>Album</code> objects.
  3.  Logs the count of returned albums.
  4.  Logs the content of the first album.
  5.  Verifies that each the value in the first album is valid (i.e., has the expected form).

##  Test Log

<code>test_get_albums.xml</code>
```xml
<get_albums_test>
  <summary errors='0' failures='0' verdicts='8'/>
  <test_method name='get_albums_test' timestamp='2017-09-22-Fri-09.39.59.937'>
    <section duration_seconds='8.309' name='With ExampleRestClient'>
      <section name='Test endpoint GET albums'>
        <section name='GET albums'>
          <section name='GET albums' timestamp='2017-09-22-Fri-09.39.59.937'>
            <section duration_seconds='0.016' method='GET' name='Rest client' timestamp='2017-09-22-Fri-09.39.59.937' url='https://jsonplaceholder.typicode.com/albums'>
              <parameters/>
            </section>
            <section name='Evaluation'>
              <data fetched_object_count='100'/>
              <section name='First fetched'>
                <data field='id' value='1'/>
                <data field='userId' value='1'/>
                <data field='title' value='quidem molestiae enim'/>
              </section>
              <verdict id='GET albums - class' message='First object is of class Album' method='verdict_assert_instance_of?' outcome='passed' volatile='false'>
                <exp_value>Album</exp_value>
                <act_value>
                  #&lt;Album:0x2de69b8 @fields=#&lt;Set: {:id, :userId,
                  :title}&gt;, @userId=1, @id=1, @title=&quot;quidem molestiae
                  enim&quot;&gt;
                </act_value>
              </verdict>
              <section name='verdict_assert_integer_positive?'>
                <verdict id='GET albums - id - integer' message='Album id' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                  <exp_value>Fixnum</exp_value>
                  <act_value>1</act_value>
                </verdict>
                <verdict id='GET albums - id - positive' message='Album id' method='verdict_assert_operator?' outcome='passed' volatile='false'>
                  <object_1>1</object_1>
                  <operator>:&gt;</operator>
                  <object_2>0</object_2>
                </verdict>
              </section>
              <section name='verdict_assert_integer_positive?'>
                <verdict id='GET albums - user id - integer' message='Album user id' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                  <exp_value>Fixnum</exp_value>
                  <act_value>1</act_value>
                </verdict>
                <verdict id='GET albums - user id - positive' message='Album user id' method='verdict_assert_operator?' outcome='passed' volatile='false'>
                  <object_1>1</object_1>
                  <operator>:&gt;</operator>
                  <object_2>0</object_2>
                </verdict>
              </section>
              <section name='verdict_assert_string_not_empty?'>
                <verdict id='GET albums - title - string' message='Album title' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                  <exp_value>String</exp_value>
                  <act_value>quidem molestiae enim</act_value>
                </verdict>
                <verdict id='GET albums - title - not empty' message='Album title' method='verdict_refute_empty?' outcome='passed' volatile='false'>
                  <act_value>quidem molestiae enim</act_value>
                </verdict>
              </section>
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
</get_albums_test>
```

Notes:

- The <code>section</code> elements organize the log.
- Each <code>section</code> element whose <code>name</code> is <code>Rest client</code> records an interaction with the REST API, including any passed parameters.
- Each <code>verdict</code> element contains a verification.
- The <code>section</code> whose <code>name</code> is <code>Evaluation</code> contains verdicts about the returned data.