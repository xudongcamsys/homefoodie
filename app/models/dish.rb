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

end

