# Preview all emails at http://localhost:3000/rails/mailers/reminder_mailer
class ReminderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/reminder_mailer/remind
  def remind
    @reminder = Reminder.first
    @user = Reminder.first.user
    ReminderMailer.with(reminder: @reminder, user: @user).remind
  end

end
