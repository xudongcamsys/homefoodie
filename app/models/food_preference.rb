class FoodPreference < ActiveRecord::Base
  has_many :dishes
  after_commit :reindex_dishes

  validates :name, presence: true, uniqueness: true

  def reindex_dishes
    dishes.reindex
  end
end
