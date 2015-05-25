class Dish < ActiveRecord::Base
  searchkick

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

  def raters_count
    Rate.where(rateable_id: id, dimension: RATE_DIMENSION_DISH).pluck(:rater_id).uniq.count
  end

  def search_data
    if user && user.location && user.location.is_visible
      lat = user.location.lat
      lng = user.location.lng
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
      cuisine: cuisine_name
    }
  end

end

