require_relative '../../../lib/base_classes/base_class_for_data'

require_relative '../data/geo'

class Photo < BaseClassForData

  FIELDS = Set.new([
         :albumId,
         :id,
         :title,
         :url,
         :thumbnailUrl,
  ])

  # # This is redundant, but it helps RubyMine code inspection.
  # attr_accessor \

  attr_accessor *FIELDS

  # Constructor.
  Contract Hash => nil
  def initialize(values = {})
    super(FIELDS, values)
    nil
  end

  Contract Log, String => Bool
  def verdict_valid?(log, verdict_id)
    if log.verdict_assert_instance_of?(verdict_id + ' - class', Photo, self, 'First object is of class Photo')
      log.va_integer_positive?(verdict_id + ' - album id', self.albumId, 'Photo album id')
      log.va_integer_positive?(verdict_id + ' - id', self.id, 'Photo id')
      log.va_string_not_empty?(verdict_id + ' - title', self.title, 'Photo title')
      log.va_string_not_empty?(verdict_id + ' - url', self.url, 'Photo url')
      log.va_string_not_empty?(verdict_id + ' - thumbnailUrl', self.thumbnailUrl, 'Photo thumbnailUrl')
    end
  end

  def self.get_all(client)
    require_relative '../endpoints/users/get_users'
    GetPhotos.call(client)
  end

end
