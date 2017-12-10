require_relative '../../base_classes/base_class_for_test'

require_relative '../../../data/label'

class ExistenceTest < BaseClassForTest

  def test_existence

    prelude do |log, api_client|

      label_to_create = Label.new(
                                 :name => 'test_label',
                                 :color => '000000',
                                 :default => false,
      )

      existing_label = nil
      log.section('Create a label') do
        label_to_create.delete_if_exist?(api_client)
        existing_label = label_to_create.create(api_client)
      end

      log.section('Determine existence') do
        exist = existing_label.exist?(api_client)
        comment = format('Label exists? %s', exist)
        log.comment(comment)
      end

      log.section('Assert existence in verdict') do
        existing_label.verdict_assert_exist?(api_client, log, :assert_exist)
      end

      log.section('Delete if exist') do
        deleted = existing_label.delete_if_exist?(api_client)
        comment = format('Label deleted? %s', deleted)
        log.comment(comment)
      end

      log.section('Refute existence in verdict') do
        existing_label.verdict_refute_exist?(api_client, log, :refute_exist)
      end

    end

  end

end