class UserMailer < ApplicationMailer
  def invitation(user, workspace)
    @user = user
    @workspace =  workspace
    mail to: @user.email, subject: 'Glenfiddichへ招待されました!'
  end
end
