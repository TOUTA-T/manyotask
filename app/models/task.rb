class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :detail, presence: true

  scope :name_like, -> (name) { where('name LIKE ?',  "%#{name}%") }
  scope :status, -> (status) { where(status: "#{status}") }
  scope :double, -> (name, status) { where('name LIKE ?',  "%#{name}%").where(status: "#{status}")}
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
end
