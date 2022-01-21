# => Creates a 5-character hash to be used as the #to_param
module FriendlyID
  extend ActiveSupport::Concern

  included do
    before_create :assign_friendly_id
  end

  def to_param
    friendly_id
  end

  def assign_friendly_id
    self.friendly_id = loop do
      random = SecureRandom.urlsafe_base64(5, false)
      break random unless self.class.exists?(friendly_id: random)
    end
  end
end