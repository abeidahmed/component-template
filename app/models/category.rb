class Category < ApplicationRecord
  include PagesHelper

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :categorizable, polymorphic: true
  has_many :components
  has_many :pages

  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
