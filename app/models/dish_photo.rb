class DishPhoto < ActiveRecord::Base
  belongs_to :dish
  
  validates :title, presence: true
  validates :dish, presence: true

  mount_uploader :image, DishPhotoUploader

  acts_as_likeable

  # public activity
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }, recipient: Proc.new{ |controller, model| model.dish.try(:user) } 
end
