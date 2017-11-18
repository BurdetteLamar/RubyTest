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