class User < ApplicationRecord
  USER_ROLES = %w(Reader User Administrator Editor)

  scope :staff,   -> { where("role != ?", "Reader") }
  scope :readers, -> { where(role: "Reader") }
  
  validates :name, presence: true, length: { :in => 2..60 }

  validates :title, presence: true, length: { :in => 2..80 }
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  
  validates :role, presence: true, inclusion: { :in => USER_ROLES }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  devise :omniauthable, omniauth_providers: [:facebook]

  def is_role?(role)
    self.role === role
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email    = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name     = auth.info.name 
      user.avatar   = auth.info.image
      user.title    = 'Reader'
    end
  end
end
