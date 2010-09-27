class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += "メールアドレスのご確認"
    @body[:url]  = "http://localhost:3000/activate/#{user.activation_code}"
  end

  def activation(user)
    setup_email(user)
    @subject    += "アカウント開設手続きが完了しました。"
    @body[:url]  = "http://localhost:3000/"
  end

  def reset_notification(user)
    setup_email(user)
    @subject    += "パスワードの再設定のご案内"
    @body[:url]  = "http://www.mysite.com/reset/#{user.reset_code}"
  end

  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "ADMINEMAIL"
      @subject     = "[YOURSITE] "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
