class Article < ApplicationRecord
  has_many :pages,  dependent: :destroy
  has_many :medias, dependent: :destroy

  belongs_to :creator, class_name: 'User'
  belongs_to :issue, counter_cache: true
  belongs_to :author

  validates :issue, presence: true
  validates :title, presence: true, format: { with: /\A[a-zA-Z0-9 -?!:,']+\z/ }, uniqueness: { case_sensitive: false, scope: :issue_id }
  validates :social_title, format: { with: /\A[a-zA-Z0-9 -?!:,']+\z/ }, uniqueness: { case_sensitive: false, scope: :issue_id }, allow_blank: true

  before_validation :assign_position, :sanitize_content
  before_validation :check_for_valid_issue_id, :if => :issue_id_changed?
  before_create :assign_content

  after_update :assign_friendly_id, :update_page_friendly_ids, :if => :title_changed?
  after_update :update_page_issue_id,     :if => :issue_id_changed?

  before_create :assign_friendly_id

  acts_as_commentable

  mount_uploader :thumbnail, ThumbnailUploader
	mount_uploader :social_thumbnail, SocialThumbUploader
  mount_uploader :title_pic, TitlePicUploader

  def to_param
    friendly_id
  end

  def front_page
    pages.order(:position).first
  end

  def custom_thumb?
    thumbnail.present?
  end

  def custom_thumbnail_url
    ( self.custom_thumb? ) ? self.thumbnail_url : self.pages.first.image_url(:thumb)
  end

  protected
    def check_for_valid_issue_id
      unless Issue.exists?(self.issue_id)
        self.errors.add(:base, 'The issue provided does not exist') and return false
      end
    end

    def assign_position
      self.position = self.issue.articles_count + 1 if self.position.nil?
    end

    def assign_friendly_id
      self.friendly_id = self.title.parameterize
    end

    # => bulk transaction? definitely can be.
    def update_page_friendly_ids
      ActiveRecord::Base.transaction do
        self.pages.each do |page|
          page.update_attribute(:friendly_id, "#{self.title}".parameterize)
        end
      end
    end

    def update_page_issue_id
      ActiveRecord::Base.transaction do
        self.pages.each do |page|
          page.update_attribute(:issue_id, self.issue_id)
        end
      end
    end

    def sanitize_content
      self.content = self.content.html_safe.gsub("'", %q(\\\')) unless self.content.blank?
      self.description = self.description.html_safe unless self.description.blank?
    end

    def assign_content
      self.content = "<p>Content not available for this article.</p>" if self.content.blank?
    end
end
