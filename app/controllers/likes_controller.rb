class LikesController < ApplicationController
	def create
		@like = current_user.likes.create(post_id: params[:post_id])
		redirect_back(fallback_location: root_path)
		
		# いいねを押したタイミングで通知レコードを作成
		post.create_notification_like!(current_user)
	end

	def destroy
		@like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
		@like.destroy
		redirect_back(fallback_location: root_path)
	end
end
