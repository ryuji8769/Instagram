class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end


  # usersコントローラーで「フォロー一覧」と「フォロワー一覧」を表示するために必要なアクション
  def following
    @user  = User.find(params[:id])
  end

  def follower
    @user  = User.find(params[:id])
  end


end
