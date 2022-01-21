class Hyperlink < ApplicationRecord
  VALID_URL_REGEX = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix

  belongs_to :page
  belongs_to :user
  
  validates :page, presence: true
  validates :coord_y, :coord_x, :coord_w, :coord_h, presence: true
  # validates :source_url, format: { with: VALID_URL_REGEX }

  # after_initialize :prepend_http
  before_create :assign_uuid, :assign_label_color

  protected
    def prepend_http
      self.source_url = "http://#{source_url}" unless self.source_url.blank? || self.source_url =~/^https?:\/\//
    end

    def assign_uuid
      self.uuid = loop do
        random = SecureRandom.urlsafe_base64(5, false)
        break random unless self.class.exists?(uuid: random)
      end
    end

    def assign_label_color
      self.label_color = "%06x" % (rand * 0xffffff)
    end
end
