require_relative '../../base_classes/base_class_for_test'

class SecondTest < BaseClassForTest

  def test_second
    prelude do |log|
      with_ui_client(log) do |ui_client|
        ui_client.login
      end
    end
  end

end