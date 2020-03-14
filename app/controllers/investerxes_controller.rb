class InvesterxesController < ApplicationController
before_action :require_user_logged_in
before_action :correct_user, only: [:destroy]
  def index
  end
  
  def new
    @investerx = Investerx.new
  end
  
  def create
    @investerx = current_user.investerxes.build(investerx_params)
    if @investerx.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to current_user
    else
      @investerxes = current_user.investerxes.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @investerx.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def investerx_params
    params.require(:investerx).permit(:content)
  end
  
  def correct_user
    @investerx = current_user.investerxes.find_by(id: params[:id])
    unless @investerx
    redirect_to root_url
    end
  end
end