# Preview all emails at http://localhost:3000/rails/mailers/habit_mailer
class HabitMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/habit_mailer/send_when_signup
  def send_when_signup
    HabitMailer.send_when_signup
  end

end
