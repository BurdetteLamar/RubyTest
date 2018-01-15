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
    new_label_button.click
    create_label_name_text_field.set(label_name)
    create_label_color_text_field.set(label.color)
    create_label_button.click
    create_label_cancel_button.click
    nil
  end

  Contract Label => nil
  def create_label!(label)
    ApiClient.with(ui_client.log, ui_client.username, ui_client.password, ui_client.repo_name) do |api_client|
      label.delete_if_exist?(api_client)
    end
    ui_client.browser.refresh
    create_label(label)
  end

  Contract Label => Label
  def read_label(label)
    label_index = label_index_for(label.name)
    edit_button(label_index)
    edit_button(label_index).click
    label_name = edit_label_name_text_field(label_index).value
    label_color = edit_label_color_text_field(label_index).value
    edit_label_cancel_button(label_index).click
    Label.new(
        {
            :name => label_name,
            :color => label_color,
        }
    )
  end

  Contract Label, Label => nil
  def update_label(target_label, source_label)
    label_index = label_index_for(target_label.name)
    edit_button(label_index)
    edit_button(label_index).click
    edit_label_name_text_field(label_index).set(source_label.name)
    edit_label_color_text_field(label_index).set(source_label.color)
    edit_label_save_changes_button(label_index).click
    nil
  end

  Contract Label => nil
  def delete_label(label)
    label_index = label_index_for(label.name)
    delete_button(label_index).click
    delete_label_button(label_index).click
    nil
  end

  # Convenience.

  Contract Label => nil
  def wait_for_label(label)
    Watir::Wait.until(
        message: format('Did not find label "%s"', label.name),
        timeout: 5
    ) do
      label_names.include?(label.name)
    end
    nil
  end

  # Verdicts

  # Contract Log, VERDICT_ID, Label => Bool
  def verdict_assert_exist?(log, verdict_id, label)
    if log.verdict_assert_includes?([verdict_id, :exist], label_names, label.name)
      label_read = read_label(label)
      Label.verdict_equal?(log, [verdict_id, :equal], label, label_read)
    end
  end

  Contract Log, VERDICT_ID, Label => Bool
  def verdict_refute_exist?(log, verdict_id, label)
    log.verdict_refute_includes?(verdict_id, label_names, label.name)
  end
  private

  Contract Label => ArrayOf[String]
  def label_names
    locate(:label_name_spans).collect {|span| span.text}
  end

  Contract String => Num
  def label_index_for(label_name)
    label_index = label_names.index(label_name)
    if label_index.nil?
      message = format('Did not find label name "%s" among %s', label_name, label_names.inspect)
      raise ArgumentError.new(message)
    end
    label_index
  end

  Contract Num => Watir::Button
  def new_label_button
    locate(:new_label_button)
  end

  Contract Num => Watir::Button
  def create_label_button
    locate(:create_label_button)
  end

  Contract Num => Watir::Button
  def create_label_cancel_button
    locate(:cancel_buttons)[0]
  end

  Contract Num => Watir::Button
  def edit_button(label_index)
    locate(:edit_buttons)[label_index]
  end

  Contract Num => Watir::Button
  def edit_label_cancel_button(label_index)
    # First is for cancelling create, followed by pairs for cancelling delete/edit.
    locate(:cancel_buttons)[2 + 2 * label_index]
  end

  Contract Num => Watir::Button
  def edit_label_save_changes_button(label_index)
    locate(:save_changes_buttons)[label_index]
  end

  Contract Num => Watir::Button
  def delete_button(label_index)
    locate(:delete_buttons)[label_index]
  end

  Contract Num => Watir::Button
  def delete_label_button(label_index)
    locate(:delete_label_buttons)[label_index]
  end

  Contract Num => Watir::TextField
  def create_label_name_text_field
    locate(:create_label_name_text_field)
  end

  Contract Num => Watir::TextField
  def create_label_color_text_field
    locate(:create_label_color_text_field)
  end

  Contract Num => Watir::TextField
  def edit_label_color_text_field(label_index)
    locate(:edit_label_color_text_fields)[label_index]
  end

  Contract Num => Watir::TextField
  def edit_label_name_text_field(label_index)
    locate(:edit_label_name_text_fields)[label_index]
  end

end
