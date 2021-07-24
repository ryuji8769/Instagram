class RelationshipsController < ApplicationController
  def new
  end


  # ユーザーをフォローできるfollowアクションと、ユーザーへのフォロー
  # を外すことができるunfollowアクションを定義
  def follow
    current_user.follow(params[:id])
    # フォローをしたタイミングで通知レコードを作成
    @user.create_notification_follow!(current_user)
    redirect_back(fallback_location: root_path)
  end

  def unfollow
    current_user.unfollow(params[:id])
    # フォローをしたタイミングで通知レコードを作成
    @user.create_notification_unfollow(current_user)
    redirect_back(fallback_location: root_path)
  end


end
