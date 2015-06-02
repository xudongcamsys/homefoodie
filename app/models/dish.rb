require 'geokit'
class Dish < ActiveRecord::Base
  searchkick callbacks: :async, locations: ["location"]

  belongs_to :food_preference
  belongs_to :food_type
  belongs_to :cuisine
  belongs_to :user
  has_many :dish_photos, dependent: :destroy

  validates :name, presence: true
  validates :user, presence: true

  acts_as_taggable
  acts_as_commentable

  RATE_DIMENSION_DISH = 'dish'
  ratyrate_rateable RATE_DIMENSION_DISH

  def rates
    Rate.where(rateable_id: id, dimension: RATE_DIMENSION_DISH)
  end

  def raters_count
    rates.pluck(:rater_id).uniq.count
  end

  def rating
    rates.average(:stars) || -1
  end

  def search_data
    if user && user.location && user.location.is_visible
      lat = user.location.lat
      lng = user.location.lng
    else
      lat = 1000
      lng = 1000
    end

    pref_name = food_preference.name if food_preference
    type_name = food_type.name if food_type
    cuisine_name = cuisine.name if cuisine
    
    {
      name: name,
      ingredients: ingredients,
      location: [lat, lng],
      food_preference: pref_name,
      food_type: type_name,
      cuisine: cuisine_name,
      updated_at: updated_at,
      rating: rating
    }
  end

  # miles between a specific dish and given lat/lng location
  def distance_to(lat, lon)
    dish_loc = user.location rescue nil
    if dish_loc && dish_loc.is_visible
      Geokit::LatLng.new(lat, lon).distance_to(Geokit::LatLng.new(dish_loc.lat, dish_loc.lng))
    end
  end

end

