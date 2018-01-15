<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Meet the Log and Clients](./Meet.md#meet-the-log-and-clients)

**Next Stop:** [Rest API Test](./RestApi.md#rest-api-test)


# Web UI Test

Here's a simple web UI test, one that tests CRUD methods (create, read, update, delete) to operate on `Label` objects.

## Example Test

<code>web_ui_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

require_relative '../../ui/pages/labels_page'

class WebUiTest < BaseClassForTest

  def test_web_ui

    prelude do |log|

      with_ui_client(log) do |ui_client|

        label_to_create = nil

        ui_client.login
        labels_page = LabelsPage.new(ui_client).visit

        log.section('Create label') do
          label_to_create = Label.provisioned
          # The value for field :default is not available in the web UI.
          label_to_create.default = nil
          labels_page.create_label!(label_to_create)
          labels_page.wait_for_label(label_to_create)
          labels_page.verdict_assert_exist?(log, :label_created, label_to_create)
        end

        log.section('Read label') do
          label_to_read = label_to_create
          label_read = labels_page.read_label(label_to_read)
          Label.verdict_equal?(log, :label_read, label_to_read, label_read)
        end

        label_source = nil
        log.section('Update label') do
          label_source = label_to_create.perturb
          # The value for field :default is not available in the web UI.
          label_source.default = nil
          labels_page.update_label(label_to_create, label_source)
          labels_page.wait_for_label(label_source)
          labels_page.verdict_assert_exist?(log, :label_updated, label_source)
        end

        log.section('Delete label') do
          label_to_delete = label_source
          labels_page.delete_label(label_to_delete)
          ui_client.browser.refresh
          labels_page.verdict_refute_exist?(log, :label_deleted, label_to_delete)
        end

      end
    end
  end

end
```

Notes:

- The test first:
  - Declares variable `label_to_create` to house data for creating a label.
- It then calls methods:
  - `ui_client.login` to log into the web UI.
  - `LabelsPage.new(ui_client).visit` to visit the labels page.
- In section `Create` the test calls methods:
  - `Label.provisioned` to acquire a provisioned label object, ready for creation.
  - `labels_page.create_label!` to first delete the label if it exists, then creates the label.  (Method `:create_label`, without the exclamation point, would fail if the label exists.)
  - `labels_page.wait_for_label` to wait for the created label to appear.
  - `labels_page.verdict_assert_exist?` to verify that the new label exists.  Symbol `:label_created` is a verdict identifier.
- In section `Read` the test call methods:
  - `labels_page.read_label` to read the new label in the UI.
  - `Label.verdict_equal?` to verify that the label read is correct.  Symbol `:label_read` is a verdict identifier.
- In section `Update` the test calls methods:
  - `label_to_create.perturb` to modify the label to be updated.
  - `labels_page.update_label` to update the label.
  - `labels_page.wait_for_label` to wait for the updated label to appear.
  - `labels_page.verdict_assert_exist?` to verify that the updated label appears on the page.  Symbol `:label_updated` is a verdict identifer.
- In section `Delete` the test calls methods:
  - `labels_page.delete_label` to delete the label.
  - `ui_client.browser.refresh` to refresh the page.
  - `labels_page.verdict_refute_exist?` to verify that the label no longer appears on the page.  Symbol `:label_deleted` is a verdict identifier.

**Prev Stop:** [Meet the Log and Clients](./Meet.md#meet-the-log-and-clients)

**Next Stop:** [Rest API Test](./RestApi.md#rest-api-test)

