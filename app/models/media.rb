class Media < ApplicationRecord
  belongs_to :article, counter_cache: true
  belongs_to :creator, class_name: 'User'
  belongs_to :issue

  validates :article, :creator, presence: true

  before_create :assign_issue
  before_validation :prepend_http

  mount_uploader :asset, PhotoUploader
  process_in_background :asset

  include FriendlyID

  before_save :assign_position, :assign_media_type

  def presentation_url
    ( self.asset.blank? ) ? self.override_url : self.asset_url
  end

  def thumbnail
    if self.asset.blank?
      url = 'https://s3-us-west-2.amazonaws.com/shiftdrink/static/video-icon.png'
    else
      url = self.asset_url
    end
    
    url
  end

  protected
    def assign_position
      self.position = self.article.media_count + 1 if self.position.nil?
    end

    def assign_media_type
      self.media_type = ( self.asset.blank? ) ? 'Video' : 'Photo'
    end

    def assign_issue
      self.issue_id = self.article.issue_id
    end

    def prepend_http
      self.override_url = "http://#{override_url}" unless self.override_url =~ /^https?:\/\//
    end
end
