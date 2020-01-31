class NotificationMailer < ApplicationMailer
  default from: "huzimokunn0@gmail.com"

  def send_confirm_to_user(user)
    @user = user
    mail(
      subject: "会員登録が完了しました。", #メールのタイトル
      to: @user.email #宛先
    ) do |format|
      format.text
    end
  end
  def send_ivate_to_user(user)
    @user = User.all
    @user.each do |u|
    mail(
      subject: "今日のおすすめの本はありませんか？",
      to: u.email
    ) do |format|
      format.text
    end
  end
end
end