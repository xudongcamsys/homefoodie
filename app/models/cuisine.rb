class Cuisine < ActiveRecord::Base
  has_many :dishes
  after_commit :reindex_dishes

  validates :name, presence: true, uniqueness: true

  def reindex_dishes
    Dish.reindex
  end
end
