require_relative '../base_classes/base_class_for_page'

require_relative '../../api/api_client'

class LabelsPage < BaseClassForPage

  LOCATORS = {
      # Label names.
      :label_name_spans => [:spans, {:class => 'label-name'}],
      # For creating a label.
      :new_label_button => [:button, {:type => 'button'}],
      :create_label_name_text_field => [:text_field, {:id => 'label-name-'}],
      :create_label_color_text_field => [:text_field, {:id => 'label-color-'}],
      :create_label_button => [:button, {:visible_text => /Create label/i}],
      # For reading/updating a label.
      :edit_buttons => [:buttons, {:text => 'Edit'}],
      :edit_label_name_text_fields => [:text_fields, {:id => /label-name-\d+/}],
      :edit_label_color_text_fields => [:text_fields, {:id => /label-color-\d+/}],
      :save_changes_buttons => [:buttons, {:text => 'Save changes'}],
      # For deleting a label.
      :delete_buttons => [:buttons, {:text => 'Delete'}],
      :delete_label_buttons => [:buttons, {:text => 'Delete label'}],
      # For creating, editing, or deleting a label.
      :cancel_buttons => [:buttons, {:text => 'Cancel'}],
  }


  Contract UiClient => nil
  def initialize(ui_client)
    relative_url = File.join(ui_client.username, ui_client.repo_name, 'labels')
    super(ui_client, relative_url, LOCATORS)
  end

  # CRUD.

  Contract Label => nil
  def create_label(label)
    label_name = label.name
    locate(:new_label_button).click
    locate(:create_label_name_text_field).set(label_name)
    locate(:create_label_color_text_field).set(label.color)
    locate(:create_label_button).click
    nil
  end

  Contract Label => nil
  def create_label!(label)
    ApiClient.with(ui_client.log, ui_client.username, ui_client.password, ui_client.repo_name) do |api_client|
      p label.delete_if_exist?(api_client)
    end
    ui_client.browser.refresh
    create_label(label)
  end

  Contract Label => Label
  def read_label(label)
    label_index = get_label_index(label.name)
    p get_edit_button(label_index)
    get_edit_button(label_index).click
    label_name = get_edit_label_name_text_field(label_index).value
    label_color = get_edit_label_color_text_field(label_index).value
    Label.new(
        {
            :name => label_name,
            :color => label_color,
        }
    )
  end

  Contract Label => nil
  def delete_label(label)
    label_index = get_label_index(label.name)
    get_delete_button(label_index).click
    get_delete_label_button(label_index).click
    nil
  end

  # Convenience.

  Contract Label => ArrayOf[String]
  def get_label_names
    locate(:label_name_spans).collect {|span| span.text}
  end

  Contract String => Num
  def get_label_index(label_name)
    label_names = get_label_names
    label_index = label_names.index(label_name)
    if label_index.nil?
      message = format('Did not find label name "%s" among %s', label_name, label_names.inspect)
      raise ArgumentError.new(message)
    end
    label_index
  end

  Contract Num => Watir::Button
  def get_edit_button(label_index)
    locate(:edit_buttons)[label_index]
  end

  Contract Num => Watir::TextField
  def get_edit_label_color_text_field(label_index)
    locate(:edit_label_color_text_fields)[label_index]
  end

  Contract Num => Watir::TextField
  def get_edit_label_name_text_field(label_index)
    locate(:edit_label_name_text_fields)[label_index]
  end

  Contract Num => Watir::Button
  def get_edit_label_cancel_button(label_index)
    # First is for cancelling create, followed by pairs for cancelling edit/delete.
    locate(:cancel_buttons)[1 + 2 * label_index]
  end

  Contract Num => Watir::Button
  def get_delete_button(label_index)
    locate(:delete_buttons)[label_index]
  end

  Contract Num => Watir::Button
  def get_delete_label_button(label_index)
    locate(:delete_label_buttons)[label_index]
  end

  def wait_for_label(label)
    Watir::Wait.until(
        message: format('Did not find label "%s"', label.name),
        timeout: 5
    ) do
      get_label_names.include?(label.name)
    end
  end
end
