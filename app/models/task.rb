class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :detail, presence: true
  #渡されたdate_field_tagをdatetimeに変換
  # class :task < Task
  #   REGISTRABLE_ATTRIBUTES = %i(
  #   name
  #   deadline(1i) deadline(2i) deadline(3i) deadline(4i) deadline(5i)
  #   )
  # end
  # 並び替えはこちらでもできるが、保守性の観点でモデルのデフォルトにするのは▲
  # default_scope -> { order(created_at: :desc)}
end
