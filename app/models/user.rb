class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_one :profile

  def set_default_role
    self.role ||= :user
  end

  def profile
    super || build_profile
  end 

  

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # follow a user and allow to be followed
  acts_as_follower
  acts_as_followable

  private

  def build_profile
    Profile.create(user: self)
  end

end
