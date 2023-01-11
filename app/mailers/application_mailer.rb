class ApplicationMailer < ActionMailer::Base
  default from: 'Habit配信メール',
          bcc: ENV['HABIT_MAILER_ADDRESS'],
          reply_to: ENV['HABIT_MAILER_ADDRESS']
  layout 'mailer'
end
