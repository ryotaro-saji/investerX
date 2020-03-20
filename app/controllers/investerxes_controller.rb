class InvesterxesController < ApplicationController
before_action :require_user_logged_in
before_action :correct_user, only: [:destroy]
 
  
  def new
    @investerx = Investerx.new
  end
  
  def create
    @investerx = current_user.investerxes.build(investerx_params)
    if @investerx.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to current_user
    else
      @investerxes = current_user.feed_investerxes.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。1文字～255文字以内で投稿してください。'
      render 'investerxes/new'
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