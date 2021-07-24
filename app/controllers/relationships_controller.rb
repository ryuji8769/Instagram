class RelationshipsController < ApplicationController
  def new
  end


  # ユーザーをフォローできるfollowアクションと、ユーザーへのフォロー
  # を外すことができるunfollowアクションを定義
  def follow
    current_user.follow(params[:id])
    redirect_back(fallback_location: root_path)
  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_back(fallback_location: root_path)
  end

  
end
