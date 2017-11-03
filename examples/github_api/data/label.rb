require_relative '../base_classes/base_class_for_resource'

class Label < BaseClassForResource

  FIELDS = Set.new([
      :id,
      :url,
      :name,
      :color,
      :default,
  ])

  attr_accessor *FIELDS

  # Constructor.
  Contract Hash => nil
  def initialize(values = {})
    super(FIELDS, values)
  end

  Contract Log, String, Symbol => Bool
  def verdict_field_valid?(log, verdict_id, field)
    value = self.send(field)
    case field
      when :id
        log.verdict_assert_integer_positive?(verdict_id, value)
      when :url
        log.verdict_assert_match?(verdict_id, %r|^https://api.github.com/repos|, value)
      when :name
        log.verdict_assert_string_not_empty?(verdict_id, value)
      when :color
        hex_color_regex = /[0-9a-f]{6}/i
        log.verdict_assert_match?(verdict_id, hex_color_regex, value)
      when :default
        log.verdict_assert_boolean?(verdict_id, value)
      else
        ArgumentError.new(field.inspect)
    end
  end

  def self.invalid_value_for(field)
    case field
      when :id
        -1
      when :url
        'not a url'
      when :name
        ''
      when :color
        'red'
      when :default
        'not a boolean'
      else
        raise ArgumentError.new(field)
    end
  end

  # CRUD.

  Contract GithubClient, Label => Label
  def self.create(client, label)
    require_relative '../endpoints/labels/post_labels'
    PostLabels.call(client, label)
  end

  Contract GithubClient, Label => Label
  def self.read(client, label)
    require_relative '../endpoints/labels/get_labels_name'
    GetLabelsName.call(client, label)
  end

  Contract GithubClient, Label => Label
  def self.update(client, label)
    require_relative '../endpoints/labels/patch_labels_name'
    PatchLabelsName.call(client, label)
  end

  Contract GithubClient, Label => nil
  def self.delete(client, label)
    require_relative '../endpoints/labels/delete_labels_name'
    DeleteLabelsName.call(client, label)
  end

  # Convenience.

  Contract GithubClient => ArrayOf[Label ]
  def self.get_all(client)
    require_relative '../endpoints/labels/get_labels'
    GetLabels.call(client)
  end

  # This is harmlessly redundant, but helps RubyMine code inspection.
  attr_accessor \
    :color

end
