class User < ActiveRecord::Base
  include PublicActivity::Common

  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_one :profile, dependent: :destroy
  has_one :location, dependent: :destroy
  has_many :dishes, dependent: :destroy

  mount_uploader :avatar, AvatarUploader
  accepts_nested_attributes_for :location

  # tag owner
  acts_as_tagger

  # rater
  ratyrate_rater

  def set_default_role
    self.role ||= :user
  end

  def profile
    super || build_profile
  end 

  def location
    super || build_location
  end 

  def visible_location
    location.try(:is_visible) ? location : nil
  end

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # follow a user and allow to be followed
  acts_as_follower
  acts_as_followable

  # liker
  acts_as_liker

  # omniauth for multiple providers
  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )

        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  private

  def build_profile
    Profile.create(user: self)
  end

  def build_location
    Location.create(user: self)
  end

end
