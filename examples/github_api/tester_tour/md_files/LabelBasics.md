<!--- GENERATED FILE, DO NOT EDIT --->

# Label Basics Test

## Example Test

<code>label_basics_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/labels/delete_labels_name'
require_relative '../../endpoints/labels/get_labels'
require_relative '../../endpoints/labels/get_labels_name'
require_relative '../../endpoints/labels/patch_labels_name'
require_relative '../../endpoints/labels/post_labels'

class LabelBasicsTest < BaseClassForTest

  def test_label_basics

    prelude do |client, log|

      log.section('Test GetLabels') do
        GetLabels.verdict_call_and_verify_success(client, log, 'Get labels')
      end

      label_created = nil
      log.section('Test PostLabels') do
        label_to_create = Label.new(
            :id => nil,
            :url => nil,
            :name => 'test_label',
            :color => '000000',
            :default => false,
        )
        Label.delete_if_exist?(client, label_to_create)
        label_created = PostLabels.verdict_call_and_verify_success(client, log, 'create label', label_to_create)
      end

      log.section('Test GetLabelsName') do
        GetLabelsName.verdict_call_and_verify_success(client, log, 'get label', label_created)
      end

      label_updated = nil
      log.section('Test PatchLabelsName') do
        label_to_update = Label.deep_clone(label_created)
        label_to_update.color = 'ffffff'
        label_updated = PatchLabelsName.verdict_call_and_verify_success(client, log, 'update label', label_to_update)
      end

      log.section('Test DeleteLabelsName') do
        label_to_delete = Label.deep_clone(label_updated)
        DeleteLabelsName.verdict_call_and_verify_success(client, log, 'delete label', label_to_delete)
      end

    end

  end

end
```

Notes:

## Log

<code>test_label_basics.xml</code>
```xml
<label_basics_test>
  <summary errors='0' failures='0' verdicts='45'/>
  <test_method name='label_basics_test' timestamp='2017-10-17-Tue-15.36.40.069'>
    <section name='With GithubClient'>
      <section name='Test GetLabels'>
        <section name='Get labels' timestamp='2017-10-17-Tue-15.36.40.070'>
          <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels'>
            <execution duration_seconds='1.684' timestamp='2017-10-17-Tue-15.36.40.071'/>
          </GithubClient>
          <section name='Evaluation'>
            <data fetched_labels_count='8'/>
            <section name='First label fetched'>
              <section name='Label'>
                <data field='id' value='710733208'/>
                <data field='url' value='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/bug'/>
                <data field='name' value='bug'/>
                <data field='color' value='ee0701'/>
                <data field='default' value='true'/>
              </section>
            </section>
            <section name='verdict_assert_integer_positive?'>
              <verdict id='Get labels valid id - integer' message='id is positive integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                <exp_value>Integer</exp_value>
                <act_value>710733208</act_value>
              </verdict>
              <verdict id='Get labels valid id - positive' message='id is positive integer' method='verdict_assert_operator?' outcome='passed' volatile='false'>
                <object_1>710733208</object_1>
                <operator>:&gt;</operator>
                <object_2>0</object_2>
              </verdict>
            </section>
            <verdict id='Get labels valid url' message='url starts with' method='verdict_assert_match?' outcome='passed' volatile='false'>
              <exp_value>/^https:\/\/api.github.com\/repos/</exp_value>
              <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/bug</act_value>
            </verdict>
            <section name='verdict_assert_string_not_empty?'>
              <verdict id='Get labels valid name - string' message='name is nonempty string' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                <exp_value>String</exp_value>
                <act_value>bug</act_value>
              </verdict>
              <verdict id='Get labels valid name - not empty' message='name is nonempty string' method='verdict_refute_empty?' outcome='passed' volatile='false'>
                <act_value>bug</act_value>
              </verdict>
            </section>
            <verdict id='Get labels valid color' message='color is hex color' method='verdict_assert_match?' outcome='passed' volatile='false'>
              <exp_value>/[0-9a-f]{6}/i</exp_value>
              <act_value>ee0701</act_value>
            </verdict>
            <verdict id='Get labels valid default' message='default is boolean' method='verdict_assert_includes?' outcome='passed' volatile='false'>
              <exp_value>[TrueClass, FalseClass]</exp_value>
              <act_value>TrueClass</act_value>
            </verdict>
          </section>
        </section>
        <section name='Test PostLabels'>
          <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
            <execution timestamp='2017-10-17-Tue-15.36.41.770'>
              <section name='create label' timestamp='2017-10-17-Tue-15.36.42.056'>
                <GithubClient method='POST' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels'>
                  <parameters color='000000' name='test_label'/>
                  <execution duration_seconds='0.293' timestamp='2017-10-17-Tue-15.36.42.056'/>
                </GithubClient>
                <section name='Evaluation'>
                  <section name='Created label correct'>
                    <verdict id='create label name' message='Label name' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                      <exp_value>test_label</exp_value>
                      <act_value>test_label</act_value>
                    </verdict>
                    <verdict id='create label color' message='Label color' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                      <exp_value>000000</exp_value>
                      <act_value>000000</act_value>
                    </verdict>
                  </section>
                  <section name='Created label valid'>
                    <section name='verdict_assert_integer_positive?'>
                      <verdict id='create label valid id - integer' message='id is positive integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                        <exp_value>Integer</exp_value>
                        <act_value>722929777</act_value>
                      </verdict>
                      <verdict id='create label valid id - positive' message='id is positive integer' method='verdict_assert_operator?' outcome='passed' volatile='false'>
                        <object_1>722929777</object_1>
                        <operator>:&gt;</operator>
                        <object_2>0</object_2>
                      </verdict>
                    </section>
                    <verdict id='create label valid url' message='url starts with' method='verdict_assert_match?' outcome='passed' volatile='false'>
                      <exp_value>/^https:\/\/api.github.com\/repos/</exp_value>
                      <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label</act_value>
                    </verdict>
                    <section name='verdict_assert_string_not_empty?'>
                      <verdict id='create label valid name - string' message='name is nonempty string' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                        <exp_value>String</exp_value>
                        <act_value>test_label</act_value>
                      </verdict>
                      <verdict id='create label valid name - not empty' message='name is nonempty string' method='verdict_refute_empty?' outcome='passed' volatile='false'>
                        <act_value>test_label</act_value>
                      </verdict>
                    </section>
                    <verdict id='create label valid color' message='color is hex color' method='verdict_assert_match?' outcome='passed' volatile='false'>
                      <exp_value>/[0-9a-f]{6}/i</exp_value>
                      <act_value>000000</act_value>
                    </verdict>
                    <verdict id='create label valid default' message='default is boolean' method='verdict_assert_includes?' outcome='passed' volatile='false'>
                      <exp_value>[TrueClass, FalseClass]</exp_value>
                      <act_value>FalseClass</act_value>
                    </verdict>
                  </section>
                  <section name='Created label exists'>
                    <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
                      <execution duration_seconds='0.268' timestamp='2017-10-17-Tue-15.36.42.364'/>
                    </GithubClient>
                    <verdict id='create label exists' message='Label exists' method='verdict_assert?' outcome='passed' volatile='false'>
                      <act_value>true</act_value>
                    </verdict>
                  </section>
                </section>
              </section>
              <section name='Test GetLabelsName'>
                <section name='get label' timestamp='2017-10-17-Tue-15.36.42.634'>
                  <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
                    <execution duration_seconds='0.264' timestamp='2017-10-17-Tue-15.36.42.637'/>
                  </GithubClient>
                  <section name='Evaluation'>
                    <verdict id='get label name' message='Label name' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                      <exp_value>test_label</exp_value>
                      <act_value>test_label</act_value>
                    </verdict>
                    <section name='verdict_assert_integer_positive?'>
                      <verdict id='get label valid id - integer' message='id is positive integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                        <exp_value>Integer</exp_value>
                        <act_value>722929777</act_value>
                      </verdict>
                      <verdict id='get label valid id - positive' message='id is positive integer' method='verdict_assert_operator?' outcome='passed' volatile='false'>
                        <object_1>722929777</object_1>
                        <operator>:&gt;</operator>
                        <object_2>0</object_2>
                      </verdict>
                    </section>
                    <verdict id='get label valid url' message='url starts with' method='verdict_assert_match?' outcome='passed' volatile='false'>
                      <exp_value>/^https:\/\/api.github.com\/repos/</exp_value>
                      <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label</act_value>
                    </verdict>
                    <section name='verdict_assert_string_not_empty?'>
                      <verdict id='get label valid name - string' message='name is nonempty string' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                        <exp_value>String</exp_value>
                        <act_value>test_label</act_value>
                      </verdict>
                      <verdict id='get label valid name - not empty' message='name is nonempty string' method='verdict_refute_empty?' outcome='passed' volatile='false'>
                        <act_value>test_label</act_value>
                      </verdict>
                    </section>
                    <verdict id='get label valid color' message='color is hex color' method='verdict_assert_match?' outcome='passed' volatile='false'>
                      <exp_value>/[0-9a-f]{6}/i</exp_value>
                      <act_value>000000</act_value>
                    </verdict>
                    <verdict id='get label valid default' message='default is boolean' method='verdict_assert_includes?' outcome='passed' volatile='false'>
                      <exp_value>[TrueClass, FalseClass]</exp_value>
                      <act_value>FalseClass</act_value>
                    </verdict>
                  </section>
                </section>
                <section name='Test PatchLabelsName'>
                  <section name='update label' timestamp='2017-10-17-Tue-15.36.42.901'>
                    <GithubClient method='PATCH' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
                      <parameters color='ffffff'/>
                      <execution duration_seconds='0.289' timestamp='2017-10-17-Tue-15.36.42.917'/>
                    </GithubClient>
                    <section name='Evaluation'>
                      <section name='Updated label correct'>
                        <verdict id='update label updated label-id' message='Updated label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                          <exp_value>722929777</exp_value>
                          <act_value>722929777</act_value>
                        </verdict>
                        <verdict id='update label updated label-url' message='Updated label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                          <exp_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label</exp_value>
                          <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label</act_value>
                        </verdict>
                        <verdict id='update label updated label-name' message='Updated label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                          <exp_value>test_label</exp_value>
                          <act_value>test_label</act_value>
                        </verdict>
                        <verdict id='update label updated label-color' message='Updated label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                          <exp_value>ffffff</exp_value>
                          <act_value>ffffff</act_value>
                        </verdict>
                        <verdict id='update label updated label-default' message='Updated label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                          <exp_value>false</exp_value>
                          <act_value>false</act_value>
                        </verdict>
                      </section>
                      <section name='Returned label valid'>
                        <section name='verdict_assert_integer_positive?'>
                          <verdict id='update label returned label id - integer' message='id is positive integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                            <exp_value>Integer</exp_value>
                            <act_value>722929777</act_value>
                          </verdict>
                          <verdict id='update label returned label id - positive' message='id is positive integer' method='verdict_assert_operator?' outcome='passed' volatile='false'>
                            <object_1>722929777</object_1>
                            <operator>:&gt;</operator>
                            <object_2>0</object_2>
                          </verdict>
                        </section>
                        <verdict id='update label returned label url' message='url starts with' method='verdict_assert_match?' outcome='passed' volatile='false'>
                          <exp_value>/^https:\/\/api.github.com\/repos/</exp_value>
                          <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label</act_value>
                        </verdict>
                        <section name='verdict_assert_string_not_empty?'>
                          <verdict id='update label returned label name - string' message='name is nonempty string' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                            <exp_value>String</exp_value>
                            <act_value>test_label</act_value>
                          </verdict>
                          <verdict id='update label returned label name - not empty' message='name is nonempty string' method='verdict_refute_empty?' outcome='passed' volatile='false'>
                            <act_value>test_label</act_value>
                          </verdict>
                        </section>
                        <verdict id='update label returned label color' message='color is hex color' method='verdict_assert_match?' outcome='passed' volatile='false'>
                          <exp_value>/[0-9a-f]{6}/i</exp_value>
                          <act_value>ffffff</act_value>
                        </verdict>
                        <verdict id='update label returned label default' message='default is boolean' method='verdict_assert_includes?' outcome='passed' volatile='false'>
                          <exp_value>[TrueClass, FalseClass]</exp_value>
                          <act_value>FalseClass</act_value>
                        </verdict>
                      </section>
                      <section name='Fetched label correct'>
                        <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
                          <execution duration_seconds='0.295' timestamp='2017-10-17-Tue-15.36.43.225'/>
                        </GithubClient>
                        <verdict id='update label fetched label-id' message='Fetched label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                          <exp_value>722929777</exp_value>
                          <act_value>722929777</act_value>
                        </verdict>
                        <verdict id='update label fetched label-url' message='Fetched label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                          <exp_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label</exp_value>
                          <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label</act_value>
                        </verdict>
                        <verdict id='update label fetched label-name' message='Fetched label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                          <exp_value>test_label</exp_value>
                          <act_value>test_label</act_value>
                        </verdict>
                        <verdict id='update label fetched label-color' message='Fetched label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                          <exp_value>ffffff</exp_value>
                          <act_value>ffffff</act_value>
                        </verdict>
                        <verdict id='update label fetched label-default' message='Fetched label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                          <exp_value>false</exp_value>
                          <act_value>false</act_value>
                        </verdict>
                      </section>
                    </section>
                  </section>
                  <section name='Test DeleteLabelsName'>
                    <section duration_seconds='4.036' name='delete label' timestamp='2017-10-17-Tue-15.36.43.520'>
                      <GithubClient method='DELETE' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
                        <execution duration_seconds='0.302' timestamp='2017-10-17-Tue-15.36.43.520'/>
                      </GithubClient>
                      <section name='Evaluation'>
                        <verdict id='delete label payload nil' message='Payload nil' method='verdict_assert_nil?' outcome='passed' volatile='false'>
                          <act_value>nil</act_value>
                        </verdict>
                        <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
                          <execution timestamp='2017-10-17-Tue-15.36.43.827'>
                            <verdict id='delete label label deleted' message='Label not exist' method='verdict_refute?' outcome='passed' volatile='false'>
                              <act_value>false</act_value>
                            </verdict>
                          </execution>
                        </GithubClient>
                      </section>
                    </section>
                    <section name='Count of errors (unexpected exceptions)'>
                      <verdict id='error count' message='error count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
                        <exp_value>0</exp_value>
                        <act_value>0</act_value>
                      </verdict>
                    </section>
                  </section>
                </section>
              </section>
            </execution>
          </GithubClient>
        </section>
      </section>
    </section>
  </test_method>
</label_basics_test>
```

Notes:

