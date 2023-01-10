class HabitMailer < ApplicationMailer
  default from: ENV['HABIT_MAILER_ADDRESS']

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.habit_mailer.send_when_signup.subject
  #
  def send_when_signup(name, mail)
    @name = name
    mail to: mail, subject: 'ユーザー登録が完了しました'
  end
end
