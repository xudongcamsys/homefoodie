class DishPhoto < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :dish

  mount_uploader :image, DishPhotoUploader
end
