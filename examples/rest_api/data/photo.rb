require_relative '../base_classes/base_class_for_resource'

class Photo < BaseClassForResource

  FIELDS = Set.new([
         :albumId,
         :id,
         :title,
         :url,
         :thumbnailUrl,
  ])

  attr_accessor *FIELDS

  # Constructor.
  Contract Hash => nil
  def initialize(values = {})
    super(FIELDS, values)
    nil
  end

  Contract Log, String => Bool
  def verdict_valid?(log, verdict_id)
    log.verdict_assert_integer_positive?(verdict_id + ' - album id', self.albumId, 'Photo album id')
    log.verdict_assert_integer_positive?(verdict_id + ' - id', self.id, 'Photo id')
    log.verdict_assert_string_not_empty?(verdict_id + ' - title', self.title, 'Photo title')
    log.verdict_assert_string_not_empty?(verdict_id + ' - url', self.url, 'Photo url')
    log.verdict_assert_string_not_empty?(verdict_id + ' - thumbnailUrl', self.thumbnailUrl, 'Photo thumbnailUrl')
  end

  # This is redundant, but it helps RubyMine code inspection.
  attr_accessor \
      :albumId,
      :thumbnailUrl,
      :url

end
