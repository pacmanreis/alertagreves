class RemindersController < ApplicationController
  def index
    @reminders = Reminder.all
  end

  def create
    @reminder = Reminder.new
    @reminder.strike = Strike.find(params[:reminder][:strike_id])
    @reminder.user = current_user
    authorize @reminder
    @reminder.save
    redirect_to root_path, notice: "Reminder successfully created"
  end
end
