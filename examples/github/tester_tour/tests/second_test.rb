require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

require_relative '../../ui/pages/labels_page'

class SecondTest < BaseClassForTest

  def test_second
    prelude do |log|
      with_ui_client(log) do |ui_client|
        ui_client.login
        labels_page = LabelsPage.new(ui_client).visit
        label_to_create = Label.provisioned
        labels_page.create_label!(label_to_create)
        # labels_page.wait_for_label(label_to_create)
        ui_client.browser.refresh
        label_read = labels_page.read_label(label_to_create)
        ui_client.browser.refresh
        p label_read
        # label_to_update = label.perturb(label_to_create)
        # labels_page.update_label(label_to_update)
        labels_page.delete_label(label_to_create)
      end
    end
  end

end