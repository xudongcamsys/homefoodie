class Location < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true

  after_save :reindex_dishes

  def reindex_dishes
    Dish.reindex 
  end
end
