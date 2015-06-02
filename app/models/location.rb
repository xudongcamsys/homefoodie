require 'geokit'

class Location < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true

  after_save :reindex_dishes

  INVALID_LOCATION = Location.new(lat: 1000, lng: 1000).freeze.tap(&:readonly!)
  NOTABLE_DISTANCE_IN_MILE = 0.5

  def reindex_dishes
    Dish.searchkick_index.import(user.dishes)
  end

  def coords
    [lat, lng]
  end

  # only update latlng when moved distance > 0.5 mile
  # this is to reduce the cost whenever location is changed, have to reindex dishes (ElasticSearch)
  def update_latlng(new_lat, new_lng)
    return if new_lat.blank? || new_lng.blank? 

    update_attributes(lat: new_lat, lng: new_lng) if notable_distance_from?(new_lat, new_lng)
  end

  def notable_distance_from?(another_lat, another_lng)
    return unless lat && lng && another_lat && another_lng
    
    current_latlng = Geokit::LatLng.new(lat, lng)
    another_latlng = Geokit::LatLng.new(another_lat, another_lng) 
    
    current_latlng.distance_to(another_latlng) > NOTABLE_DISTANCE_IN_MILE
  end
end
