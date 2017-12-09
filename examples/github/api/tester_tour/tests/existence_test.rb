require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

class ExistenceTest < BaseClassForTest

  def test_existence

    prelude do |client, log|

      label_to_create = Label.new(
                                 :name => 'test_label',
                                 :color => '000000',
                                 :default => false,
      )

      existing_label = nil
      log.section('Create a label') do
        label_to_create.delete_if_exist?(client)
        existing_label = label_to_create.create(client)
      end

      log.section('Determine existence') do
        exist = existing_label.exist?(client)
        comment = format('Label exists? %s', exist)
        log.comment(comment)
      end

      log.section('Assert existence in verdict') do
        existing_label.verdict_assert_exist?(client, log, :assert_exist)
      end

      log.section('Delete if exist') do
        deleted = existing_label.delete_if_exist?(client)
        comment = format('Label deleted? %s', deleted)
        log.comment(comment)
      end

      log.section('Refute existence in verdict') do
        existing_label.verdict_refute_exist?(client, log, :refute_exist)
      end

    end

  end

end