class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :detail, presence: true
  # 並び替えはこちらでもできるが、保守性の観点でモデルのデフォルトにするのは▲
  # default_scope -> { order(created_at: :desc)}
end
