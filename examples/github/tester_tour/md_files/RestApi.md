<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Web UI Test](./WebUi.md#web-ui-test)

**Next Stop:** [Test Sections and Nesting](./Sections.md#test-sections-and-nesting)


# Rest API Test

Here's a simple REST API test, one that tests CRUD methods (create, read, update, delete) to operate on `Label` objects.

## Example Test

<code>rest_api_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class RestApiTest < BaseClassForTest

  def test_rest_api

    prelude do |log|

      with_api_client(log) do |api_client|

        label_to_create = Label.provisioned
        label_created = nil
        label_updated = nil

        log.section('Create') do
          label_created = label_to_create.create!(api_client)
          Label.verdict_equal?(log, :create_return_correct, label_to_create, label_created)
          label_created.verdict_read_and_verify?(api_client, log, :created_correctly)
        end

        log.section('Read') do
          label_read = label_created.read(api_client)
          Label.verdict_equal?(log, :read_correctly, label_created, label_read)
        end

        log.section('Update') do
          label_source = label_created.perturb
          label_source.url = nil
          label_source.default = nil
          label_updated = label_created.update!(api_client, label_source)
          Label.verdict_equal?(log, :update_return_correct, label_source, label_updated)
          label_updated.verdict_read_and_verify?(api_client, log, :updated_correctly)
        end

        log.section('Delete') do
          return_value = label_updated.delete(api_client)
          log.verdict_assert_nil?(:delete_return_correct, return_value)
          label_created.verdict_refute_exist?(api_client, log, :deleted_correctly)
        end

      end

    end

  end

end
```

Notes:

- The test first defines:
  - `label_to_create`, a variable to  house data for creating a label.
  - `label_created`, a variable that will house the data for a created label, including new values for `:id` and `:url`.
  - `label_updated`, a variable that will house the data for an updated label, including new values for `:id` and `:url`.
- In section `Create`:
  - `create!`, a method that first deletes the label if it exists, then creates the label.  (Method `:create`, without the exclamation point, would fail if the label exists.)
  - `:create_return_correct` and `:created_correctly`, symbols that are _verdict identifiers_.  A verdict identifier appears in each verdict method call.
  - `Label.verdict_equal?`,  a method that verifies that the returned label data is correct.
  - `label_returned.verdict_read_and_verify?`, a method that verifies that the label was correctly created in GitHub.
- In section `Read`:
  - `label_created.read` a method that reads a label, which is stored into variable `label_read`.
  - `Label.verdict_equal?`, a method that verifies that the returned label data is correct.
- In section `Update`:
  - `label_created.perturb`, a method that perturbs data from `label_created`, which is stored into `label_source`.
  - The UI does not have the label's url or default, so these are set to nil, and will be ignored.
  - `Label.verdict_equal?`, a method that verifies that the returned label data is correct.
  - `label_returned.verdict_read_and_verify?`, a method that verifies that the label was correctly updated in GitHub.
- In section `Delete`:
  - `label_updated.delete`, a method that deletes a label.
  - `log.verdict_assert_nil?`, a method that verifies that the return value is `nil`.
  - `label_created.verdict_refute_exist?`, a method that verifies that the label was deleted in GitHub.

**Prev Stop:** [Web UI Test](./WebUi.md#web-ui-test)

**Next Stop:** [Test Sections and Nesting](./Sections.md#test-sections-and-nesting)

