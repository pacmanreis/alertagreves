class ReminderMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reminder_mailer.remind.subject
  #
  def remind(user_id)
    @user = User.find(user_id)
    @reminders = @user.reminders.joins(:strike).where("strikes.start_date >= ? AND strikes.start_date <= ? ", Date.today, Date.today + 7)
    mail(to: @user.email, subject: 'Reminder of strikes')
  end
end
