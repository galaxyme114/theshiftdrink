class Page < ApplicationRecord
  default_scope { order(:position) }

  belongs_to :issue
  belongs_to :article, counter_cache: true
  belongs_to :creator, class_name: 'User'

  has_many :hyperlinks, dependent: :delete_all

  validates :article, presence: true

  before_validation :assign_position, :assign_title
  before_create :assign_issue

  after_update :reprocess_profile, :if => :cropping?
  after_update :assign_master_position
  after_create :assign_master_position

  after_destroy :assign_remaining_positions, :assign_master_position

  mount_uploader :image, PageUploader
  mount_uploader :advertisement_thumb, ThumbnailUploader

  attr_accessor :crop_x, :crop_y, :crop_h, :crop_w

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def advertisement_thumb?
    advertisement_thumb.present?
  end

  def thumbnail_url
    ( self.advertisement_thumb? ) ? self.advertisement_thumb_url(:thumb) : self.image_url(:thumb)
  end

  def self.find_for_issue(issue_id)
    includes(:hyperlinks, :article, :issue).where(issue_id: issue_id).order('master_position ASC')
  end

  protected
    def reprocess_profile
      self.image.recreate_versions!
    end

    def assign_issue
      self.issue_id = self.article.issue_id
    end

    def assign_title
      self.friendly_id = self.article.title.parameterize
    end

    def assign_position
      self.position = self.article.pages_count + 1 if self.position.blank?
    end

    def assign_remaining_positions
      values = []

      self.article.pages.where('pages.position > ?', self.position).each do |page|
        values.push("(#{page.id}, #{page.position-1})")
      end

      ActiveRecord::Base.connection.execute("UPDATE pages as p SET position = c.position from (values #{values.join(',')}) as c(identifier, position) where c.identifier = p.id;") unless values.empty?
    end

    def assign_master_position # SPEC TBD
      objects   = Page.where(issue_id: self.issue_id)
      positions = Article.where(issue_id: self.issue_id).select("id, position")

      values = []

      objects.each do |object|
        article = positions.select{|p| p.id == object.article_id }[0]
        earlier = positions.select{|p| p.position < article.position }.map(&:id)
        pages_cnt = objects.select{|o| earlier.include?(o.article_id) }.size

        values.push("(#{object.id}, #{pages_cnt + object.position})")
      end

      ActiveRecord::Base.connection.execute("UPDATE pages as p SET master_position = c.position from (values #{values.join(',')}) as c(identifier, position) where c.identifier = p.id;") unless values.empty?
    end
end
