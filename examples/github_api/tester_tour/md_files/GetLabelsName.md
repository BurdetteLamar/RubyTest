<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [PostLabels Test](./PostLabels.md#postlabels-test)

**Next Stop:** [PatchLabelsName Test](./PatchLabelsName.md#patchlabelsname-test)


# GetLabelsName Test

This is a test for endpoint `GET /labels/:name`, which fetches a label.

## Example Test

<code>get_labels_name_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/labels/get_labels_name'

class GetLabelsNameTest < BaseClassForTest

  def test_get_labels_name

    prelude do |client, log|

      log.section('Test GetLabelsName') do
        label_to_fetch = nil
        log.section('Create the label to be fetched') do
          label_to_create = Label.new(
              :id => nil,
              :url => nil,
              :name => 'test_label',
              :color => '000000',
              :default => false,
          )
          Label.delete_if_exist?(client, label_to_create)
          label_to_fetch = Label.create(client, label_to_create)
        end
        log.section('Test fetching the created label') do
          GetLabelsName.verdict_call_and_verify_success(client, :get_label, label_to_fetch)
        end
        log.section('Clean up') do
          Label.delete_if_exist?(client, label_to_fetch)
        end
      end

    end

  end

end
```

Notes:

- The test creates the label that it will fetch.
- It uses method `Label.delete_if_exist?` before and after, to avoid collisions and to clean up.
- Test uses the data-object method `Label.create` to create the label.
- Class `GetLabelsName` encapsulates the endpoint.
- Its method `verdict_call_and_verify_success`:
  - Accepts the client, a verdict id, and the label to be fetched.
  - Accesses the endpoint.
  - Forms the returned data into a `Label` object.
  - Performs verifications on the label object.
  - Returns the label object.

## Log

<code>test_get_labels_name.xml</code>
```xml
<get_labels_name_test>
  <summary errors='0' failures='0' verdicts='9'/>
  <test_method name='get_labels_name_test' timestamp='2017-11-12-Sun-08.01.57.136'>
    <section duration_seconds='5.032' name='With GithubClient'>
      <section name='Test GetLabelsName'>
        <section name='Create the label to be fetched'>
          <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test_label'>
            <execution duration_seconds='3.313' timestamp='2017-11-12-Sun-08.01.57.136'/>
          </GithubClient>
          <GithubClient method='POST' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels'>
            <parameters color='000000' name='test_label'/>
            <execution duration_seconds='0.422' timestamp='2017-11-12-Sun-08.02.00.448'/>
          </GithubClient>
        </section>
        <section name='Test fetching the created label'>
          <section name='get_label' timestamp='2017-11-12-Sun-08.02.00.870'>
            <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test_label'>
              <execution duration_seconds='0.469' timestamp='2017-11-12-Sun-08.02.00.870'/>
            </GithubClient>
            <section name='Evaluation'>
              <verdict id='get_label:name' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>test_label</exp_value>
                <act_value>test_label</act_value>
              </verdict>
              <section name='verdict_assert_integer_positive?'>
                <verdict id='get_label:valid:id:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                  <exp_value>Integer</exp_value>
                  <act_value>748036767</act_value>
                </verdict>
                <verdict id='get_label:valid:id:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
                  <object_1>748036767</object_1>
                  <operator>:&gt;</operator>
                  <object_2>0</object_2>
                </verdict>
              </section>
              <verdict id='get_label:valid:url' method='verdict_assert_match?' outcome='passed' volatile='false'>
                <exp_value>/^https:\/\/api.github.com\/repos/</exp_value>
                <act_value>https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test_label</act_value>
              </verdict>
              <section name='verdict_assert_string_not_empty?'>
                <verdict id='get_label:valid:name:string' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                  <exp_value>String</exp_value>
                  <act_value>test_label</act_value>
                </verdict>
                <verdict id='get_label:valid:name:not_empty' method='verdict_refute_empty?' outcome='passed' volatile='false'>
                  <act_value>test_label</act_value>
                </verdict>
              </section>
              <verdict id='get_label:valid:color' method='verdict_assert_match?' outcome='passed' volatile='false'>
                <exp_value>/[0-9a-f]{6}/i</exp_value>
                <act_value>000000</act_value>
              </verdict>
              <verdict id='get_label:valid:default' method='verdict_assert_includes?' outcome='passed' volatile='false'>
                <exp_value>[TrueClass, FalseClass]</exp_value>
                <act_value>FalseClass</act_value>
              </verdict>
            </section>
          </section>
          <section name='Clean up'>
            <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test_label'>
              <execution duration_seconds='0.453' timestamp='2017-11-12-Sun-08.02.01.339'/>
            </GithubClient>
            <GithubClient method='DELETE' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test_label'>
              <execution duration_seconds='0.375' timestamp='2017-11-12-Sun-08.02.01.792'/>
            </GithubClient>
          </section>
        </section>
      </section>
    </section>
    <section name='Count of errors (unexpected exceptions)'>
      <verdict id='error_count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
        <exp_value>0</exp_value>
        <act_value>0</act_value>
      </verdict>
    </section>
  </test_method>
</get_labels_name_test>
```

Notes:

- Section `GithubClient` shows the endpoint access.
- Section `Evaluation` verifies the returned label.

**Prev Stop:** [PostLabels Test](./PostLabels.md#postlabels-test)

**Next Stop:** [PatchLabelsName Test](./PatchLabelsName.md#patchlabelsname-test)

