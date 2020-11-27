class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :change
  has_many :tasks, dependent: :destroy

  after_save :ensure_admin_user
  after_destroy :ensure_last_user

  private
  def ensure_admin_user
    if User.where(admin: true).empty?
      raise "最後の管理ユーザは変更できません"
    end
  end

  def ensure_last_user
    if User.where(admin: true).empty?
      raise "最後の管理ユーザは削除できません"
    end
  end


end
