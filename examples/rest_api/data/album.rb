require_relative '../../../lib/base_classes/base_class_for_data'

class Album < BaseClassForData

  FIELDS = Set.new([
      :id,
      :userId,
      :title,
  ])

  # This is redundant, but it helps RubyMine code inspection.
  attr_accessor \
      :userId

  attr_accessor *FIELDS

  # Constructor.
  Contract Hash => nil
  def initialize(values = {})
    super(FIELDS, values)
  end

  Contract Log, String => Bool
  def verdict_valid?(log, verdict_id)
    if log.verdict_assert_instance_of?(verdict_id + ' - class', Album, self, 'First object is of class Album')
      log.va_integer_positive?(verdict_id + ' - id', self.id, 'Album id')
      log.va_integer_positive?(verdict_id + ' - user id', self.userId, 'Album user id')
      log.va_string_not_empty?(verdict_id + ' - title', self.title, 'Album title')
    end
  end

  def self.read(client, album)
    require_relative '../endpoints/albums/get_albums_id'
    GetAlbumsId(client, album)
  end

  def self.get_all(client)
    require_relative '../endpoints/albums/get_albums'
    GetAlbums.call(client)
  end

  def self.exist?(client, album)
    begin
      self.read(client, album)
      return true
    rescue
      return false
    end
  end

  def self.verdict_not_exist?(client, log, album)
    log.vr?('album_deleted', self.exist?(client, album), 'Album deleted')
  end

end
