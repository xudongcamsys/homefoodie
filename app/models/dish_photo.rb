class DishPhoto < ActiveRecord::Base
  belongs_to :dish
  
  validates :title, presence: true
  validates :dish, presence: true

  mount_uploader :image, DishPhotoUploader

  acts_as_likeable
end
