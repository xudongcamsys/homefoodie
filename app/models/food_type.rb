class FoodType < ActiveRecord::Base
  has_many :dishes

  validates :name, presence: true, uniqueness: true
end
