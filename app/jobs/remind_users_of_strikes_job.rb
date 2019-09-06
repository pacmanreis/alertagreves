class RemindUsersOfStrikesJob < ApplicationJob
  queue_as :default

  def perform()
    users_reminders_ids = Reminder.joins(:strike)
                                  .where("strikes.start_date >= ? AND strikes.start_date <= ? ", Date.today, Date.today + 7)
                                  .pluck('reminders.user_id')
                            
    users_reminders_ids.uniq.each do |user_id|
      ReminderMailer.remind(user_id).deliver_now
      puts "sending mails"
    end

    RemindUsersOfStrikesJob.set(wait: 1.week).perform_later
  end
end
