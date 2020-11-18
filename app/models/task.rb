class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :detail, presence: true
  default_scope -> { order(created_at: :desc)}
end
