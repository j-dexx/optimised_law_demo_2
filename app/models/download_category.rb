class DownloadCategory < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  validates :name, presence: true
  validates :suggested_url, allow_blank: true, uniqueness: { case_sensitive: false, message: 'is already taken, leave blank to generate automatically' }

  scope :displayed, -> { where("download_categories.display = ?", true) }

  has_many :downloads, -> { displayed }, dependent: :destroy

  def slug_candidates
    [
      :suggested_url,
      :name,
      [:suggested_url, :name]
    ]
  end

  def should_generate_new_friendly_id?
    slug.blank? || suggested_url_changed? || name_changed?
  end
end
