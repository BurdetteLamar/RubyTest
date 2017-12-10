<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Logging a Data Object](./FlatDataLog.md#logging-a-data-object)

**Next Stop:** [Verifying a Data Object](./FlatDataEqual.md#verifying-a-data-object)


# Creating a Data Object

A data object's `new` method takes a hash of name/value pairs that initialize its fields.

## Example Test

<code>flat_data_new_test.rb</code>
```ruby
require_relative '../../api/base_classes/base_class_for_test'

require_relative '../../data/label'

class FlatDataNewTest < BaseClassForTest

  def test_flat_data_new
    prelude do |log, _|
      log.section('Instantiate and log an instance of Label') do
        label = Label.new(
            :id => 710733210,
            :url => 'https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/enhancement',
            :name => 'enhancement',
            :color => '84b6eb',
            :default => true,
        )
        log.section('Instantiated label') do
          label.log(log)
        end
      end
    end
  end

end
```

Notes:

- Create a new data object by calling method `new` on the data class.
- Pass the initial values in a hash of name/value pairs.
- (Note that the instantiated `Label` exists only here in the test, and not in the Github API itself.)

## Log

<code>test_flat_data_new.xml</code>
```xml
<flat_data_new_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='0.010' name='flat_data_new_test' timestamp='2017-12-10-Sun-14.15.45.731'>
    <section name='Test'>
      <section name='Instantiate and log an instance of Label'>
        <section name='Instantiated label'>
          <section name='Label'>
            <data field='id' value='710733210'/>
            <data field='url' value='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/enhancement'/>
            <data field='name' value='enhancement'/>
            <data field='color' value='84b6eb'/>
            <data field='default' value='true'/>
          </section>
        </section>
      </section>
    </section>
  </test_method>
  <section name='Count of errors (unexpected exceptions)'>
    <verdict id='error_count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>0</act_value>
    </verdict>
  </section>
</flat_data_new_test>
```

**Prev Stop:** [Logging a Data Object](./FlatDataLog.md#logging-a-data-object)

**Next Stop:** [Verifying a Data Object](./FlatDataEqual.md#verifying-a-data-object)

