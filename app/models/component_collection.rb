class ComponentCollection < ApplicationRecord
  has_many :categories, as: :categorizable

  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
