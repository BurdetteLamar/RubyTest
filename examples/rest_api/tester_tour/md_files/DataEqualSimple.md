<!--- GENERATED FILE, DO NOT EDIT --->
[Prev](./MoreToCome.md) [Next](./DataEqualComplex.md)

# Simple Data Object Equality

## Test Source Code

<code>data_equal_simple_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../../rest_api/data/album'

class DataEqualTest < BaseClassForTest

  def test_data_equal_simple
    prelude do |client, log|
      album = Album.get_first(client)
      Album.equal?(album, album)
      Album.verdict_equal?(log, 'album equal', album, album, 'Using Album.verdict_equal?')
    end
  end

end
```

Notes:

##  Test Log

<code>test_data_equal_simple.xml</code>
```xml
<data_equal_simple_test>
  <summary errors='0' failures='0' verdicts='4'/>
  <test_method duration_seconds='1.467' name='data_equal_simple_test' timestamp='2017-09-27-Wed-08.47.01.710'>
    <section name='With ExampleRestClient'>
      <section duration_seconds='0.000' method='GET' name='Rest client' timestamp='2017-09-27-Wed-08.47.01.714' url='https://jsonplaceholder.typicode.com/albums'>
        <parameters/>
      </section>
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
  </test_method>
  <section name='Count of errors (unexpected exceptions)'>
    <verdict id='error count' message='error count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>0</act_value>
    </verdict>
  </section>
</data_equal_simple_test>
```

[Prev](./MoreToCome.md) [Next](./DataEqualComplex.md)
