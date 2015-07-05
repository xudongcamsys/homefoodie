class EventAddress < ActiveRecord::Base
  has_many :events

  def coords
    [lat, lng]
  end
end
