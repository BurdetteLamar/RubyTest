require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class FirstTest < BaseClassForTest

  def test_first

    prelude do |log|

      with_api_client(log) do |api_client|

        label_to_create = Label.provisioned
        label_created = nil

        log.section('Create') do
          label_returned = label_to_create.create!(api_client)
          Label.verdict_equal?(log, :create_return_correct, label_to_create, label_returned)
          label_returned.verdict_read_and_verify?(api_client, log, :created_correctly)
          label_created = label_returned
        end

        log.section('Read') do
          label_returned = label_created.read(api_client)
          Label.verdict_equal?(log, :read_correctly, label_created, label_returned)
        end

        log.section('Update') do
          label_to_update = label_created.perturb
          label_returned = label_to_update.update(api_client)
          label_to_update.log(log, 'Label to update')
          label_returned.log(log, 'Label returned')
          Label.verdict_equal?(log, :update_return_correct, label_to_update, label_returned)
          label_returned.verdict_read_and_verify?(api_client, log, :updated_correctly)
        end

        log.section('Delete') do
          label_returned = label_created.delete(api_client)
          log.verdict_assert_nil?(:delete_return_correct, label_returned)
          label_created.verdict_refute_exist?(api_client, log, :deleted_correctly)
        end

      end

    end

  end

end