<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [GetLabelsName Test](./GetLabelsName.md#getlabelsname-test)

**Next Stop:** [DeleteLabelsName Test](./DeleteLabelsName.md#deletelabelsname-test)


# PatchLabelsName Test

## Example Test

<code>patch_labels_name_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../api/endpoints/labels/patch_labels_name'

class PatchLabelsNameTest < BaseClassForTest

  def test_patch_labels_name

    prelude do |log|

      with_api_client(log) do |api_client|

        log.section('Test PatchLabelsName') do
          label_to_create = Label.new(
              :id => nil,
              :url => nil,
              :name => 'test_label',
              :color => '000000',
              :default => false,
          )
          label_target = label_to_create.create!(api_client)
          label_source = label_target.perturb
          label_source.url = nil
          label_source.default = nil
          PatchLabelsName.verdict_call_and_verify_success(api_client, :patch_label, label_target, label_source)
          label_source.delete_if_exist?(api_client)
        end

      end

    end

  end

end
```

This test a test for endpoint `PATCH /labels/:name`, which updates a label.

Notes:

- Class `PatchLabelsName` encapsulates the endpoint.
- Its method `verdict_call_and_verify_success`:
  - Accepts the client, a verdict id, and the label to be patched.
  - Accesses the endpoint.
  - Forms the returned data into a `Label` object.
  - Performs verifications on the label object.
  - Returns the label object.

## Log

<code>test_patch_labels_name.xml</code>
```xml
<patch_labels_name_test>
  <summary errors='0' failures='4' verdicts='9'/>
  <test_method name='patch_labels_name_test' timestamp='2018-01-15-Mon-13.29.36.411'>
    <section duration_seconds='5.616' name='Test'>
      <section name='Test PatchLabelsName'>
        <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
          <execution duration_seconds='3.682' timestamp='2018-01-15-Mon-13.29.36.411'/>
        </ApiClient>
        <ApiClient method='POST' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels'>
          <parameters color='000000' name='test_label'/>
          <execution duration_seconds='0.343' timestamp='2018-01-15-Mon-13.29.40.092'/>
        </ApiClient>
        <section name='patch_label' timestamp='2018-01-15-Mon-13.29.40.436'>
          <ApiClient method='PATCH' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
            <parameters color='ffffff' name='not test_label'/>
            <execution duration_seconds='0.390' timestamp='2018-01-15-Mon-13.29.40.436'/>
          </ApiClient>
          <section name='Evaluation'>
            <section name='Returned label correct'>
              <section class='Label' method='verdict_equal?' name='updated_label'>
                <verdict id='patch_label:updated_label:id' message='Updated label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                  <exp_value>805592977</exp_value>
                  <act_value>805592977</act_value>
                </verdict>
                <verdict id='patch_label:updated_label:url' message='Updated label correct' method='verdict_assert_equal?' outcome='failed' volatile='false'>
                  <exp_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label</exp_value>
                  <act_value>nil</act_value>
                  <exception>
                    <class>Minitest::Assertion</class>
                    <message>
                      --- expected +++ actual @@ -1,2 +1 @@ -# encoding: UTF-8
                      -&quot;https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label&quot; +nil
                    </message>
                    <backtrace>
                      <![CDATA[
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:158:in `block in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:146:in `verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:72:in `block in verdict_equal?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:71:in `verdict_equal?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/endpoints/labels/patch_labels_name.rb:32:in `block (3 levels) in verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/endpoints/labels/patch_labels_name.rb:30:in `block (2 levels) in verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/endpoints/labels/patch_labels_name.rb:29:in `block in verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/endpoints/labels/patch_labels_name.rb:27:in `verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/patch_labels_name_test.rb:25:in `block (3 levels) in test_patch_labels_name'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/patch_labels_name_test.rb:13:in `block (2 levels) in test_patch_labels_name'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:28:in `block in with_api_client'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/api_client.rb:19:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:27:in `with_api_client'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/patch_labels_name_test.rb:11:in `block in test_patch_labels_name'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:21:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:20:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:12:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/patch_labels_name_test.rb:9:in `test_patch_labels_name']]>
                    </backtrace>
                  </exception>
                </verdict>
                <verdict id='patch_label:updated_label:name' message='Updated label correct' method='verdict_assert_equal?' outcome='failed' volatile='false'>
                  <exp_value>test_label</exp_value>
                  <act_value>not test_label</act_value>
                  <exception>
                    <class>Minitest::Assertion</class>
                    <message>
                      --- expected +++ actual @@ -1,2 +1,2 @@ # encoding: UTF-8
                      -&quot;test_label&quot; +&quot;not test_label&quot;
                    </message>
                    <backtrace>
                      <![CDATA[
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:158:in `block in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:146:in `verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:72:in `block in verdict_equal?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:71:in `verdict_equal?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/endpoints/labels/patch_labels_name.rb:32:in `block (3 levels) in verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/endpoints/labels/patch_labels_name.rb:30:in `block (2 levels) in verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/endpoints/labels/patch_labels_name.rb:29:in `block in verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/endpoints/labels/patch_labels_name.rb:27:in `verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/patch_labels_name_test.rb:25:in `block (3 levels) in test_patch_labels_name'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/patch_labels_name_test.rb:13:in `block (2 levels) in test_patch_labels_name'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:28:in `block in with_api_client'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/api_client.rb:19:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:27:in `with_api_client'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/patch_labels_name_test.rb:11:in `block in test_patch_labels_name'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:21:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:20:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:12:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/patch_labels_name_test.rb:9:in `test_patch_labels_name']]>
                    </backtrace>
                  </exception>
                </verdict>
                <verdict id='patch_label:updated_label:color' message='Updated label correct' method='verdict_assert_equal?' outcome='failed' volatile='false'>
                  <exp_value>000000</exp_value>
                  <act_value>ffffff</act_value>
                  <exception>
                    <class>Minitest::Assertion</class>
                    <message>
                      --- expected +++ actual @@ -1,2 +1,2 @@ # encoding: UTF-8
                      -&quot;000000&quot; +&quot;ffffff&quot;
                    </message>
                    <backtrace>
                      <![CDATA[
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:158:in `block in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:146:in `verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:72:in `block in verdict_equal?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:71:in `verdict_equal?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/endpoints/labels/patch_labels_name.rb:32:in `block (3 levels) in verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/endpoints/labels/patch_labels_name.rb:30:in `block (2 levels) in verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/endpoints/labels/patch_labels_name.rb:29:in `block in verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/endpoints/labels/patch_labels_name.rb:27:in `verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/patch_labels_name_test.rb:25:in `block (3 levels) in test_patch_labels_name'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/patch_labels_name_test.rb:13:in `block (2 levels) in test_patch_labels_name'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:28:in `block in with_api_client'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/api_client.rb:19:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:27:in `with_api_client'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/patch_labels_name_test.rb:11:in `block in test_patch_labels_name'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:21:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:20:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:12:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/patch_labels_name_test.rb:9:in `test_patch_labels_name']]>
                    </backtrace>
                  </exception>
                </verdict>
                <verdict id='patch_label:updated_label:default' message='Updated label correct' method='verdict_assert_equal?' outcome='failed' volatile='false'>
                  <exp_value>false</exp_value>
                  <act_value>nil</act_value>
                  <exception>
                    <class>Minitest::Assertion</class>
                    <message>Expected: false Actual: nil</message>
                    <backtrace>
                      <![CDATA[
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:158:in `block in verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:146:in `verdict_equal_recursive?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:72:in `block in verdict_equal?'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/base_classes/base_class_for_data.rb:71:in `verdict_equal?'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/endpoints/labels/patch_labels_name.rb:32:in `block (3 levels) in verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/endpoints/labels/patch_labels_name.rb:30:in `block (2 levels) in verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/endpoints/labels/patch_labels_name.rb:29:in `block in verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/endpoints/labels/patch_labels_name.rb:27:in `verdict_call_and_verify_success'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/patch_labels_name_test.rb:25:in `block (3 levels) in test_patch_labels_name'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/patch_labels_name_test.rb:13:in `block (2 levels) in test_patch_labels_name'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:28:in `block in with_api_client'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/api_client.rb:19:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:27:in `with_api_client'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/patch_labels_name_test.rb:11:in `block in test_patch_labels_name'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:21:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:20:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:12:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/patch_labels_name_test.rb:9:in `test_patch_labels_name']]>
                    </backtrace>
                  </exception>
                </verdict>
              </section>
            </section>
            <section name='Label updated'>
              <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/not%20test_label'>
                <execution duration_seconds='0.374' timestamp='2018-01-15-Mon-13.29.40.950'/>
              </ApiClient>
              <section class='Label' method='verdict_equal?' name='fetched_label'>
                <verdict id='patch_label:fetched_label:id' message='Fetched label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                  <exp_value>805592977</exp_value>
                  <act_value>805592977</act_value>
                </verdict>
                <verdict id='patch_label:fetched_label:name' message='Fetched label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                  <exp_value>not test_label</exp_value>
                  <act_value>not test_label</act_value>
                </verdict>
                <verdict id='patch_label:fetched_label:color' message='Fetched label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                  <exp_value>ffffff</exp_value>
                  <act_value>ffffff</act_value>
                </verdict>
              </section>
            </section>
          </section>
          <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/not%20test_label'>
            <execution duration_seconds='0.359' timestamp='2018-01-15-Mon-13.29.41.325'/>
          </ApiClient>
          <ApiClient method='DELETE' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/not%20test_label'>
            <execution duration_seconds='0.343' timestamp='2018-01-15-Mon-13.29.41.684'/>
          </ApiClient>
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
</patch_labels_name_test>
```

Notes:

- In section `Evaluation`:
  - Section `Returned label correct` verifies the returned label.
  - Section `Label updated` verifies that the label was updated.

**Prev Stop:** [GetLabelsName Test](./GetLabelsName.md#getlabelsname-test)

**Next Stop:** [DeleteLabelsName Test](./DeleteLabelsName.md#deletelabelsname-test)

