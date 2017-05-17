require 'time'

require_relative '../../lib/base_classes/base_class'

class TimeHelper < BaseClass

  Contract Bool => String
  # Timestamp with no path-forbidden characters.
  def self.timestamp(milliseconds = false)
    now = DateTime.now
    if milliseconds
      now.strftime('%Y.%m.%d-%a-%H.%M.%S.%3N')
    else
      now.strftime('%Y.%m.%d-%a-%H.%M.%S')
    end

  end

end