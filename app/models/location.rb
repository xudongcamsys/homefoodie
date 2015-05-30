class Location < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true

  after_commit :reindex_dishes

  def reindex_dishes
    user.dishes.reindex
  end
end
