class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers, :edit, :update, :destroy]
  before_action :correct_user, only: [:destroy, :edit, :update]
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザーを登録しました。ようこそInvesterXへ！'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザーの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = 'プロフィールは正常に更新されました'
      redirect_to @user
    else
      flash.now[:danger] = 'プロフィールは更新されませんでした'
      render :edit
    end
  end  
    
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = '退会しました。ご利用ありがとうございました！'
    redirect_to "/"
  end
    
    
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def investerxes
    @user = User.find(params[:id])
    @user_investerxes = @user.feed_investerxes.order(id: :desc).page(params[:page]).per(20)
    counts(@user)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :style, :like, :book)
  end
  
  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to "/" 
      flash[:danger] = '他人のプロフィールは変更できません。'
    end
  end
end

