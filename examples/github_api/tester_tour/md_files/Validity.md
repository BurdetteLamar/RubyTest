<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Equality](./Equality.md#equality)

**Next Stop:** [More to Come ...](./MoreToCome.md#more-to-come-)


# Validity

A data class may offer convenience methods for determing and verifying validity.

## Example Test

<code>validity_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class ValidityTest < BaseClassForTest

  def test_validity

    prelude do |client, log|

      label = Label.get_first(client)

      log.section('Verify that a label is valid') do
        label.verdict_valid?(log, :valid)
      end

    end

  end

end
```

Notes:

- Method <code>Label.verdict_valild?></code> verifies (with logging) that a <code>Label</code> is valid.

## Log

<code>test_validity.xml</code>
```xml
<validity_test>
  <summary errors='0' failures='0' verdicts='8'/>
  <test_method duration_seconds='3.391' name='validity_test' timestamp='2017-11-14-Tue-12.41.12.333'>
    <section name='With GithubClient'>
      <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels'>
        <execution duration_seconds='3.391' timestamp='2017-11-14-Tue-12.41.12.333'/>
      </GithubClient>
      <section name='Verify that a label is valid'>
        <section name='verdict_assert_integer_positive?'>
          <verdict id='valid:id:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>Integer</exp_value>
            <act_value>562043326</act_value>
          </verdict>
          <verdict id='valid:id:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
            <object_1>562043326</object_1>
            <operator>:&gt;</operator>
            <object_2>0</object_2>
          </verdict>
        </section>
        <verdict id='valid:url' method='verdict_assert_match?' outcome='passed' volatile='false'>
          <exp_value>/^https:\/\/api.github.com\/repos/</exp_value>
          <act_value>https://api.github.com/repos/BurdetteLamar/RubyTest/labels/bug</act_value>
        </verdict>
        <section name='verdict_assert_string_not_empty?'>
          <verdict id='valid:name:string' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
            <exp_value>String</exp_value>
            <act_value>bug</act_value>
          </verdict>
          <verdict id='valid:name:not_empty' method='verdict_refute_empty?' outcome='passed' volatile='false'>
            <act_value>bug</act_value>
          </verdict>
        </section>
        <verdict id='valid:color' method='verdict_assert_match?' outcome='passed' volatile='false'>
          <exp_value>/[0-9a-f]{6}/i</exp_value>
          <act_value>ee0701</act_value>
        </verdict>
        <verdict id='valid:default' method='verdict_assert_includes?' outcome='passed' volatile='false'>
          <exp_value>[TrueClass, FalseClass]</exp_value>
          <act_value>TrueClass</act_value>
        </verdict>
      </section>
    </section>
  </test_method>
  <section name='Count of errors (unexpected exceptions)'>
    <verdict id='error_count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>0</act_value>
    </verdict>
  </section>
</validity_test>
```

**Prev Stop:** [Equality](./Equality.md#equality)

**Next Stop:** [More to Come ...](./MoreToCome.md#more-to-come-)

