class Component < ApplicationRecord
  belongs_to :category

  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
