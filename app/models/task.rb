class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :details, presence: true
end
