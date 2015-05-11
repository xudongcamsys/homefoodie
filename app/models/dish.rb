class Dish < ActiveRecord::Base
  belongs_to :food_preference
  belongs_to :food_type
  belongs_to :cuisine
  belongs_to :user
  has_many :dish_photos, dependent: :destroy

  validates :name, presence: true
  validates :user, presence: true

  acts_as_taggable

end
