class Post < ApplicationRecord
	mount_uploader :image, ImageUploader

	belongs_to :user
    has_many :likes
    has_many :liked_users, through: :likes, source: :user

	# コメント
	has_many :comments, dependent: :destroy

	#  紐付け（ユーザと投稿）
	belongs_to:user

	# 投稿と通知モデルの紐付け
	has_many :notifications, dependent: :destroy

    def user
        return User.find_by(id: self.user_id)
    end

	# いいね通知の作成メソッド
	def create_notification_like!(current_user)
		# すでに「いいね」されているか検索
		temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
		# いいねされていない場合のみ、通知レコードを作成
		if temp.blank?
		  notification = current_user.active_notifications.new(
			post_id: id,
			visited_id: user_id,
			action: 'like'
		  )
		  # 自分の投稿に対するいいねの場合は、通知済みとする
		  if notification.visitor_id == notification.visited_id
			notification.checked = true
		  end
		  notification.save if notification.valid?
		end
	end


	# コメント通知の作成メソッド
	def create_notification_comment!(current_user, comment_id)
		# 自分以外にコメントしている人をすべて取得し、全員に通知を送る
		temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
		temp_ids.each do |temp_id|
		  save_notification_comment!(current_user, comment_id, temp_id['user_id'])
		end
		# まだ誰もコメントしていない場合は、投稿者に通知を送る
		save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
	end
	
	  def save_notification_comment!(current_user, comment_id, visited_id)
		# コメントは複数回することが考えられるため、１つの投稿に複数回通知する
		notification = current_user.active_notifications.new(
		  post_id: id,
		  comment_id: comment_id,
		  visited_id: visited_id,
		  action: 'comment'
		)
		# 自分の投稿に対するコメントの場合は、通知済みとする
		if notification.visitor_id == notification.visited_id
		  notification.checked = true
		end
		notification.save if notification.valid?
	  end
end
