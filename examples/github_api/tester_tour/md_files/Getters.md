<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [CRUD](./Crud.md#crud)

**Next Stop:** [Equality](./Equality.md#equality)


# Getters

A data class may offer convenience methods for getting resources from the API.

## Example Test

<code>getters_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class GettersTest < BaseClassForTest

  def test_getters

    prelude do |client, log|

      log.section('Get the first label') do
        label = Label.get_first(client)
        label.log(log)
      end

      log.section('Get all labels') do
        labels = Label.get_all(client)
        labels.each do |label|
          label.log(log)
        end
      end

    end

  end

end
```

Notes:

- Method <code>Label.get_first</code> returns the first <code>Label</code> object.
- Method <code>Label.get_all</code> returns all <code>Label</code> objects.

## Log

<code>test_getters.xml</code>
```xml
<getters_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='3.844' name='getters_test' timestamp='2017-11-14-Tue-12.41.02.770'>
    <section name='With GithubClient'>
      <section name='Get the first label'>
        <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels'>
          <execution duration_seconds='3.469' timestamp='2017-11-14-Tue-12.41.02.770'/>
        </GithubClient>
        <section name='Label'>
          <data field='id' value='562043326'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/bug'/>
          <data field='name' value='bug'/>
          <data field='color' value='ee0701'/>
          <data field='default' value='true'/>
        </section>
      </section>
      <section name='Get all labels'>
        <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels'>
          <execution duration_seconds='0.375' timestamp='2017-11-14-Tue-12.41.06.239'/>
        </GithubClient>
        <section name='Label'>
          <data field='id' value='562043326'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/bug'/>
          <data field='name' value='bug'/>
          <data field='color' value='ee0701'/>
          <data field='default' value='true'/>
        </section>
        <section name='Label'>
          <data field='id' value='562043327'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/duplicate'/>
          <data field='name' value='duplicate'/>
          <data field='color' value='cccccc'/>
          <data field='default' value='true'/>
        </section>
        <section name='Label'>
          <data field='id' value='562043328'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/enhancement'/>
          <data field='name' value='enhancement'/>
          <data field='color' value='84b6eb'/>
          <data field='default' value='true'/>
        </section>
        <section name='Label'>
          <data field='id' value='562043329'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/help%20wanted'/>
          <data field='name' value='help wanted'/>
          <data field='color' value='128A0C'/>
          <data field='default' value='true'/>
        </section>
        <section name='Label'>
          <data field='id' value='562043330'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/invalid'/>
          <data field='name' value='invalid'/>
          <data field='color' value='e6e6e6'/>
          <data field='default' value='true'/>
        </section>
        <section name='Label'>
          <data field='id' value='562043331'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/question'/>
          <data field='name' value='question'/>
          <data field='color' value='cc317c'/>
          <data field='default' value='true'/>
        </section>
        <section name='Label'>
          <data field='id' value='562043332'/>
          <data field='url' value='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/wontfix'/>
          <data field='name' value='wontfix'/>
          <data field='color' value='ffffff'/>
          <data field='default' value='true'/>
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
</getters_test>
```

**Prev Stop:** [CRUD](./Crud.md#crud)

**Next Stop:** [Equality](./Equality.md#equality)

