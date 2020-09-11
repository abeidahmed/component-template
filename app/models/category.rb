class Category < ApplicationRecord
  # extend FriendlyId
  # friendly_id :title, use: :slugged

  # scope :sort_asc, -> { order("created_at ASC") }
  belongs_to :categorizable, polymorphic: true

  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
