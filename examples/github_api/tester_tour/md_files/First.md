<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Meet the Client and Log](./Meet.md#meet-the-client-and-log)

**Next Stop:** [Test Sections and Nesting](./Sections.md#test-sections-and-nesting)


# First Test

Here's a simple first test, one that tests CRUD methods (create, read, update, delete) to operate on `Label` objects.

## Example Test

<code>first_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class FirstTest < BaseClassForTest

  def test_first

    prelude do |client, log|

      label_to_create = Label.provisioned
      label_created = nil

      log.section('Create') do
        label_returned = label_to_create.create!(client)
        Label.verdict_equal?(log, :create_return_correct, label_to_create, label_returned)
        label_returned.verdict_read_and_verify?(client, log, :created_correctly)
        label_created = label_returned
      end

      log.section('Read') do
        label_returned = label_created.read(client)
        Label.verdict_equal?(log, :read_correctly, label_created, label_returned)
      end

      log.section('Update') do
        label_to_update = label_created.perturb
        label_returned = label_created.update(client)
        Label.verdict_equal?(log, :update_return_correct, label_created, label_returned)
        label_returned.verdict_read_and_verify?(client, log, :updated_correctly)
      end

      log.section('Delete') do
        label_returned = label_created.delete(client)
        log.verdict_assert_nil?(:delete_return_correct, label_returned)
        label_created.verdict_refute_exist?(client, log, :deleted_correctly)
      end

    end

  end

end
```

Notes:

- The test first defines variables:
  - `label_to_create`, which gets data for creating a label via method `Label.provisioned`.
  - `label_created`, which will have the data for the created label, including new values for `:id` and `:url`.
- In section `Create`:
  - Instead of method `create`, we use method `create!`, which first deletes the label if it exists.
  - Symbols `:create_return_correct` and `:created_correctly` are _verdict identifiers_.  A verdict identifier appears in each verdict method call.
  - Method `Label.verdict_equal?` verifies that the returned label data is correct.
  - Method `label_returned.verdict_read_and_verify?` verifies that the label was correctly created in GitHub.
  - Variable `label_created` saves the label data for use in the following sections.
- Inn section `Read`:
  - Method `Label.verdict_equal?` verifies that the returned label data is correct.
- Inn section `Update`:
  - Method `Label.verdict_equal?` verifies that the returned label data is correct.
  - Method `label_returned.verdict_read_and_verify?` verifies that the label was correctly updated in GitHub.
- In section `Delete`:
  - Method `log.verdict_assert_nil?` verifies that the return value is `nil`.
  - Method `label_created.verdict_refute_exist?` verifies that the label was deleted in GitHub.

## Log

You're welcome to review this log, but the smaller logs in other tour stops will introduce log features step by step.

<code>test_first.xml</code>
```xml
<first_test>
  <summary errors='0' failures='0' verdicts='26'/>
  <test_method name='first_test' timestamp='2017-12-02-Sat-12.53.32.874'>
    <section name='With GithubClient'>
      <section name='Create'>
        <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test%20label'>
          <execution duration_seconds='3.360' timestamp='2017-12-02-Sat-12.53.32.890'/>
        </GithubClient>
        <GithubClient method='POST' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels'>
          <parameters color='000000' name='test label'/>
          <execution duration_seconds='0.328' timestamp='2017-12-02-Sat-12.53.36.250'/>
        </GithubClient>
        <section class='Label' method='verdict_equal?' name='create_return_correct'>
          <verdict id='create_return_correct:name' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>test label</exp_value>
            <act_value>test label</act_value>
          </verdict>
          <verdict id='create_return_correct:color' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>000000</exp_value>
            <act_value>000000</act_value>
          </verdict>
          <verdict id='create_return_correct:default' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>false</exp_value>
            <act_value>false</act_value>
          </verdict>
          <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test%20label'>
            <execution duration_seconds='0.312' timestamp='2017-12-02-Sat-12.53.36.578'/>
          </GithubClient>
          <section class='Label' method='verdict_equal?' name='created_correctly'>
            <verdict id='created_correctly:id' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>767615791</exp_value>
              <act_value>767615791</act_value>
            </verdict>
            <verdict id='created_correctly:url' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test%20label</exp_value>
              <act_value>https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test%20label</act_value>
            </verdict>
            <verdict id='created_correctly:name' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>test label</exp_value>
              <act_value>test label</act_value>
            </verdict>
            <verdict id='created_correctly:color' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>000000</exp_value>
              <act_value>000000</act_value>
            </verdict>
            <verdict id='created_correctly:default' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>false</exp_value>
              <act_value>false</act_value>
            </verdict>
          </section>
          <section name='Read'>
            <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test%20label'>
              <execution duration_seconds='0.328' timestamp='2017-12-02-Sat-12.53.36.890'/>
            </GithubClient>
            <section class='Label' method='verdict_equal?' name='read_correctly'>
              <verdict id='read_correctly:id' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>767615791</exp_value>
                <act_value>767615791</act_value>
              </verdict>
              <verdict id='read_correctly:url' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test%20label</exp_value>
                <act_value>https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test%20label</act_value>
              </verdict>
              <verdict id='read_correctly:name' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>test label</exp_value>
                <act_value>test label</act_value>
              </verdict>
              <verdict id='read_correctly:color' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>000000</exp_value>
                <act_value>000000</act_value>
              </verdict>
              <verdict id='read_correctly:default' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>false</exp_value>
                <act_value>false</act_value>
              </verdict>
            </section>
            <section duration_seconds='5.922' name='Update'>
              <GithubClient method='PATCH' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test%20label'>
                <parameters color='000000'/>
                <execution duration_seconds='0.328' timestamp='2017-12-02-Sat-12.53.37.218'/>
              </GithubClient>
              <section class='Label' method='verdict_equal?' name='update_return_correct'>
                <verdict id='update_return_correct:id' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                  <exp_value>767615791</exp_value>
                  <act_value>767615791</act_value>
                </verdict>
                <verdict id='update_return_correct:url' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                  <exp_value>https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test%20label</exp_value>
                  <act_value>https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test%20label</act_value>
                </verdict>
                <verdict id='update_return_correct:name' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                  <exp_value>test label</exp_value>
                  <act_value>test label</act_value>
                </verdict>
                <verdict id='update_return_correct:color' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                  <exp_value>000000</exp_value>
                  <act_value>000000</act_value>
                </verdict>
                <verdict id='update_return_correct:default' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                  <exp_value>false</exp_value>
                  <act_value>false</act_value>
                </verdict>
                <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test%20label'>
                  <execution duration_seconds='0.328' timestamp='2017-12-02-Sat-12.53.37.546'/>
                </GithubClient>
                <section class='Label' method='verdict_equal?' name='updated_correctly'>
                  <verdict id='updated_correctly:id' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                    <exp_value>767615791</exp_value>
                    <act_value>767615791</act_value>
                  </verdict>
                  <verdict id='updated_correctly:url' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                    <exp_value>https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test%20label</exp_value>
                    <act_value>https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test%20label</act_value>
                  </verdict>
                  <verdict id='updated_correctly:name' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                    <exp_value>test label</exp_value>
                    <act_value>test label</act_value>
                  </verdict>
                  <verdict id='updated_correctly:color' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                    <exp_value>000000</exp_value>
                    <act_value>000000</act_value>
                  </verdict>
                  <verdict id='updated_correctly:default' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                    <exp_value>false</exp_value>
                    <act_value>false</act_value>
                  </verdict>
                </section>
                <section name='Delete'>
                  <GithubClient method='DELETE' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test%20label'>
                    <execution duration_seconds='0.344' timestamp='2017-12-02-Sat-12.53.37.875'/>
                  </GithubClient>
                  <verdict id='delete_return_correct' method='verdict_assert_nil?' outcome='passed' volatile='false'>
                    <act_value>nil</act_value>
                  </verdict>
                  <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/RubyTest/labels/test%20label'>
                    <execution duration_seconds='0.578' timestamp='2017-12-02-Sat-12.53.38.218'/>
                  </GithubClient>
                  <verdict id='deleted_correctly' method='verdict_refute?' outcome='passed' volatile='false'>
                    <act_value>false</act_value>
                  </verdict>
                </section>
              </section>
            </section>
            <section name='Count of errors (unexpected exceptions)'>
              <verdict id='error_count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
                <exp_value>0</exp_value>
                <act_value>0</act_value>
              </verdict>
            </section>
          </section>
        </section>
      </section>
    </section>
  </test_method>
</first_test>
```

**Prev Stop:** [Meet the Client and Log](./Meet.md#meet-the-client-and-log)

**Next Stop:** [Test Sections and Nesting](./Sections.md#test-sections-and-nesting)

