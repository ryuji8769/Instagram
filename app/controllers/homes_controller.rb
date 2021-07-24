class HomesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_post, only[:user_show, :edit, :update, :destroy]


	def index

	end


#省略

#@userにモデルで定義したuserメソッドを@post.userで代入
#@postsに@userの投稿を全て代入
def user_show
    @user = @post.user
    @posts = @user.posts
end

#省略

private
#Post.find_by(id: params[:id])はよく使うので定義しといてbefore_actionで反映。
def set_post
   @post = Post.find_by(id: params[:id])
end
end
