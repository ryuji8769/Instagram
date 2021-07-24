class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # コメントと通知モデルの紐付け
  has_many :notifications, dependent: :destroy

end
