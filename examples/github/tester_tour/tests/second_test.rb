require_relative '../../base_classes/base_class_for_test'

require_relative '../../ui/pages/labels_page'

class SecondTest < BaseClassForTest

  def test_second
    prelude do |log|
      with_ui_client(log) do |ui_client|
        ui_client.login
        page = LabelsPage.new(ui_client).visit
      end
    end
  end

end