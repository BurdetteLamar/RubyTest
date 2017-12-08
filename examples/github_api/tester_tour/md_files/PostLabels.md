<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [GetLabels Test](./GetLabels.md#getlabels-test)

**Next Stop:** [GetLabelsName Test](./GetLabelsName.md#getlabelsname-test)


# PostLabels Test

This is a test for endpoint `POST /labels`, which creates a label.

## Example Test

<code>post_labels_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/labels/post_labels'

class PostLabelsTest < BaseClassForTest

  def test_post_labels

    prelude do |client, log|

      label_to_create = Label.new(
          :id => nil,
          :url => nil,
          :name => 'test_label',
          :color => '000000',
          :default => false,
      )
      log.section('Test PostLabels') do
        label_to_create.delete_if_exist?(client)
        PostLabels.verdict_call_and_verify_success(client, :post_label, label_to_create)
      end
      log.section('Clean up') do
        label_to_create.delete_if_exist?(client)
      end

    end

  end

end
```

Notes:

- The test calls method `Label#delete_if_exist?` before the creation, to avoid collision with an existing label.
- Class `PostLabels` encapsulates endpoint `POST /labels`.
- Its method `PostLabels.verdict_call_and_verify_success`:
  - Accepts the client, a verdict id, and the label to be created.
  - Accesses the endpoint.
  - Forms the returned data into a `Label` object.
  - Performs verifications on the label object.
  - Returns the label object.
- The test calls method `Label#delete_if_exist?` after the creation, to clean up.

## Log

<code>test_post_labels.xml</code>
```xml
<post_labels_test>
  <summary errors='0' failures='0' verdicts='11'/>
  <test_method name='post_labels_test' timestamp='2017-12-07-Thu-10.49.59.920'>
    <section duration_seconds='4.844' name='With GithubClient'>
      <section name='Test PostLabels'>
        <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test_label'>
          <execution duration_seconds='3.266' timestamp='2017-12-07-Thu-10.49.59.920'/>
        </GithubClient>
        <section name='post_label' timestamp='2017-12-07-Thu-10.50.03.186'>
          <GithubClient method='POST' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels'>
            <parameters color='000000' name='test_label'/>
            <execution duration_seconds='0.469' timestamp='2017-12-07-Thu-10.50.03.186'/>
          </GithubClient>
          <section name='Evaluation'>
            <section name='Returned label correct'>
              <verdict id='post_label:name' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>test_label</exp_value>
                <act_value>test_label</act_value>
              </verdict>
              <verdict id='post_label:color' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>000000</exp_value>
                <act_value>000000</act_value>
              </verdict>
            </section>
            <section name='Returned label valid'>
              <section class='Label' method='verdict_valid?' name='valid'>
                <section name='verdict_assert_integer_positive?'>
                  <verdict id='post_label:valid:id:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                    <exp_value>Integer</exp_value>
                    <act_value>772516463</act_value>
                  </verdict>
                  <verdict id='post_label:valid:id:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
                    <object_1>772516463</object_1>
                    <operator>:&gt;</operator>
                    <object_2>0</object_2>
                  </verdict>
                </section>
                <verdict id='post_label:valid:url' method='verdict_assert_match?' outcome='passed' volatile='false'>
                  <exp_value>/^https:\/\/api.github.com\/repos/</exp_value>
                  <act_value>https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test_label</act_value>
                </verdict>
                <section name='verdict_assert_string_not_empty?'>
                  <verdict id='post_label:valid:name:string' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                    <exp_value>String</exp_value>
                    <act_value>test_label</act_value>
                  </verdict>
                  <verdict id='post_label:valid:name:not_empty' method='verdict_refute_empty?' outcome='passed' volatile='false'>
                    <act_value>test_label</act_value>
                  </verdict>
                </section>
                <verdict id='post_label:valid:color' method='verdict_assert_match?' outcome='passed' volatile='false'>
                  <exp_value>/[0-9a-f]{6}/i</exp_value>
                  <act_value>000000</act_value>
                </verdict>
                <verdict id='post_label:valid:default' method='verdict_assert_includes?' outcome='passed' volatile='false'>
                  <exp_value>[TrueClass, FalseClass]</exp_value>
                  <act_value>FalseClass</act_value>
                </verdict>
              </section>
            </section>
            <section name='Label created'>
              <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test_label'>
                <execution duration_seconds='0.328' timestamp='2017-12-07-Thu-10.50.03.655'/>
              </GithubClient>
              <verdict id='post_label:exists' method='verdict_assert?' outcome='passed' volatile='false'>
                <act_value>true</act_value>
              </verdict>
            </section>
          </section>
        </section>
        <section name='Clean up'>
          <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test_label'>
            <execution duration_seconds='0.344' timestamp='2017-12-07-Thu-10.50.03.983'/>
          </GithubClient>
          <GithubClient method='DELETE' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test_label'>
            <execution duration_seconds='0.438' timestamp='2017-12-07-Thu-10.50.04.327'/>
          </GithubClient>
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
</post_labels_test>
```

Notes:

- Section `GithubClient` shows the endpoint access, including the parameters.
- In section `Evaluation`:
  - Section `Returned label correct` verifies the created label: `:name` and `:color`.
  - Section `Returned label valid` validates the created label: all fields.
  - Section `Label exists` fetches the new label and verifies all its fields.

**Prev Stop:** [GetLabels Test](./GetLabels.md#getlabels-test)

**Next Stop:** [GetLabelsName Test](./GetLabelsName.md#getlabelsname-test)

