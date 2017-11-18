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

      label_to_create = Label.new(
          :id => nil,
          :url => nil,
          :name => 'label name',
          :color => '000000',
          :default => false,
      )
      label_created = nil

      log.section('Create') do
        label_created = label_to_create.create!(client)
        Label.verdict_equal?(log, :label_created, label_to_create, label_created)
        label_created.verdict_assert_exist?(client, log, :label_exists)
      end

      log.section('Read') do
        label_read = label_created.read(client)
        Label.verdict_equal?(log, :label_read, label_created, label_read)
      end

      log.section('Update') do
        label_created.color = 'ffffff'
        label_updated = label_created.update(client)
        Label.verdict_equal?(log, :label_updated, label_created, label_updated)
      end

      log.section('Delete') do
        label_created.delete(client)
        label_created.verdict_refute_exist?(client, log, :label_not_exist)
      end

    end

  end

end
```

Notes:

- The test first defines variables:
  - `label_to_create`, which has data for creating a label.
  - `label_created`, which will have the data for the created label, including new values for `:id` and `:url`.
- In section `Create`:
  - Instead of method `create`, we use method `create!`, which first deletes the label if it exists.
  - Symbols `:label_created` and `:label_exists` are _verdict identifiers_.  A verdict identifier appears in each verict method call.
  - Method `Label.verdict_equal?` verifies that the returned label data is correct.
  - Method `label_created.verdict_assert_exist?` verifies that the label now actually exists in Github.
- In section `Delete`:
  - Method `label_created.verdict_refute_exist?` verifies that the label no longer exists in Github.

**Prev Stop:** [Meet the Client and Log](./Meet.md#meet-the-client-and-log)

**Next Stop:** [Test Sections and Nesting](./Sections.md#test-sections-and-nesting)

