class Issue < ApplicationRecord
  scope :published, 							-> { where('published_on IS NOT NULL') }
  scope :publications,      			-> { where(role: 'Issue') }
  scope :materials,         			-> { where(role: 'Material') }

  belongs_to :creator, class_name: 'User'

  has_many :articles, dependent: :destroy
  has_many :pages, through: :articles, dependent: :destroy

	validates :title, presence: true
  validates :alias_name, presence: true
  validates :orientation, presence: true, :inclusion => { :in => ['mobile', 'desktop'] }

  validates :number, presence: true, uniqueness: { case_sensitive: false }, :if => lambda { self.role == 'Issue' }
  validates :number, allow_blank: true, format: { with: /\A[0-9][0-9][0-9]\z/ }

  validates :alias_name, presence: true, uniqueness: { case_sensitive: false }, :if => lambda { self.role == 'Issue' }
  validates :alias_name, format: { with: /\A[a-zA-Z0-9-]+\z/ }

  before_validation :assign_friendly_id
  before_create :assign_preview_token
  after_create :save_first_article

  def to_param
		alias_name
  end

  def is_issue?
    role == 'Issue'
  end

  def displayed_title
    ( self.is_issue? ) ? "Issue #{number}: #{title}" : title
  end

  def first_article
    articles.order(:position).first
  end

  def issue_format
		sizes = FastImage.size(self.front_page.image_url)
		"#{sizes[0]} x #{sizes[1]}"
  end

  # SPEC TBD
  def front_page
    first_article.front_page
  end

  protected
    def save_first_article
      articles.create(title: 'Change Article Title')
    end

    def assign_friendly_id
      self.friendly_id = self.title.parameterize
    end

    def assign_preview_token
      self.preview_token = loop do
        random = SecureRandom.urlsafe_base64(8, false)
        break random unless self.class.exists?(preview_token: random)
      end
    end
end
