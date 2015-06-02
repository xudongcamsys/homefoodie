require 'geokit'

class Location < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true

  after_save :reindex_dishes

  INVALID_LOCATION = Location.new(lat: 1000, lng: 1000).readonly

  def reindex_dishes
    user.dishes.each { |dish| dish.reindex }
  end

  def coords
    [lat, lng]
  end

  # only update latlng when moved distance > 0.5 mile
  # this is to reduce the cost whenever location is changed, have to reindex dishes (ElasticSearch)
  def update_latlng(new_lat, new_lng)
    new_lat = new_lat.try(:to_f) if !new_lat.blank?
    new_lng = new_lng.try(:to_f) if !new_lng.blank?

    # calculate moved distance
    dist = distance_from new_lat, new_lng

    # only when location change is noticeable
    if dist and dist > 0.5 # 1 mile
      update_attributes(lat: new_lat, lng: new_lng) 
    end
  end

  def distance_from(another_lat, another_lng)
    if lat and lng and another_lat and another_lng
      current_latlng = Geokit::LatLng.new(lat, lng)
      another_latlng = Geokit::LatLng.new(another_lat, another_lng) 
      
      current_latlng.distance_to another_latlng 
    end
  end
end
