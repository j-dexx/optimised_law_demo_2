class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  mount_uploader :image, ArticleUploader

  belongs_to :article_category
  belongs_to :team_member
  has_many :service_articles, dependent: :destroy
  has_many :services, through: :service_articles

  validates :title, :summary, :content, :article_category_id, presence: true
  validates :suggested_url, allow_blank: true, uniqueness: { case_sensitive: false, message: 'is already taken, leave blank to generate automatically' }

  scope :displayed, -> { joins(:article_category).where("articles.display = ? AND date <= ?", true, Date.today).order(date: :desc).merge(ArticleCategory.displayed) }

  def slug_candidates
    [
      :suggested_url,
      :title,
      [:suggested_url, :title]
    ]
  end

  def should_generate_new_friendly_id?
    slug.blank? || suggested_url_changed? || title_changed?
  end
end
