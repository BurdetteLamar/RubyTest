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