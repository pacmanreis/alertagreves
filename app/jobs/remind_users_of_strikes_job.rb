class RemindUsersOfStrikesJob < ApplicationJob
  queue_as :default

  def perform()
    # Get users that need to be reminded
    reminders = Reminder.joins(:strike).where("date(strikes.start_date) = ?", Date.today + 2.days)
    # iterate over them and send email
    reminders.each do |reminder|
      puts "sending emails..."
    end
    # set next job executition
    RemindUsersOfStrikesJob.set(wait: 1.day).perform_later
  end
end
