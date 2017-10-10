require_relative '../base_classes/base_class_for_resource'

class IssueLabel < BaseClassForResource

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
        message = format('%s is positive integer', field)
        log.verdict_assert_integer_positive?(verdict_id, value, message)
      when :url
        message = format('%s starts with', field)
        log.verdict_assert?(verdict_id, value.start_with?('https://api.github.com/repos'), message)
      when :name
        message = format('%s is nonempty string', field)
        log.verdict_assert_string_not_empty?(verdict_id, value, message)
      when :color
        message = format('%s is hex color')
        hex_color_regex = /[0-9a-f]{6}/i
        log.verdict_assert_match?(verdict_id, hex_color_regex, value, message)
      when :default
        message = format('%s is boolean')
        log.verdict_assert_boolean?(verdict_id, actual, message)
      else
        ArgumentError.new(field.inspect)
    end
  end

  Contract GithubClient, Fixnum => ArrayOf[IssueLabel ]
  def self.get_all(client,  issue_number)
    require_relative '../endpoints/get_issues_number_labels'
    GetIssuesNumberLabels.call(client, issue_number,)
  end

  Contract GithubClient, Fixnum => self
  def self.get_first(client, issue_number)
    all = self.get_all(client, issue_number)
    raise RuntimeError.new('No %s available' % self.name) unless all.size > 0
    self.get_all(client, issue_number).first
  end

end
