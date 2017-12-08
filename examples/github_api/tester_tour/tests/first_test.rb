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
        label_returned = label_to_update.update(client)
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