class ActivationsController < ApplicationController
  skip_before_action :require_sign_in!
  before_action :set_authenticated_user, only: %i(create)
  
  def create
    return activation_failed if @user.nil?
    
    @user.update!(activated: true)
    log_in(@user)
    
    # @note ログインが完了したらパスワードを再設定させる
    redirect_to edit_password_resets_path
  end
  
  def set_authenticated_user
    user = User.find_by(email: params.permit[:email])

    # user が nil or 認証で失敗した場合は明示的に nil を返す
    @user = if user&.authenticated?(:invite, params[:id])
              user
            else
              nil
            end
  end
  
  def activation_failed
    flash[:alert] = '該当のユーザーが存在しませんでした。オーナーに再度招待をしてもらって下さい'
    # @todo 共通エラー用のpartial とかを render する
  end
end