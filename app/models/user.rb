class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


    #  紐付け（ユーザと投稿）
  has_many :posts, dependent: :destroy, foreign_key: :post_user_id

  # コメント
  has_many :comments, dependent: :destroy


  # 通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  # いいね
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

# フォロー
  has_many :following, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy

  has_many :following_user, through: :following, source: :follower
  has_many :follower_user, through: :follower, source: :following


  # フォローするための関数
  def follow(user_id)
    following.create(follower_id: user_id)
  end

  # フォローを外すための関数
  def unfollow(user_id)
    following.find_by(follower_id: user_id).destroy
  end


  # ユーザーを既にフォローしているかを調べる関数
  def following?(user_id)
    following_user.include?(user_id)
  end
end
