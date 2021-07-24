class Post < ApplicationRecord
	mount_uploader :image, ImageUploader

	belongs_to :user
    has_many :likes
    has_many :liked_users, through: :likes, source: :user

	# コメント
	has_many :comments, dependent: :destroy

	#  紐付け（ユーザと投稿）
	belongs_to:user

    def user
        return User.find_by(id: self.user_id)
    end
end
