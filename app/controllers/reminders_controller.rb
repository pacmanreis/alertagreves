class RemindersController < ApplicationController
  def index
    @reminders = policy_scope(Reminder).where(user_id: current_user.id)
  end

  def create
    @reminder = Reminder.new
    @reminder.strike = Strike.find(params[:reminder][:strike_id])
    @reminder.user = current_user
    authorize @reminder
    @reminder.save
    redirect_to root_path, notice: "Reminder successfully created"
  end

  def destroy
    @reminder = Reminder.find(params[:id])
    authorize @reminder
    @reminder.destroy
    redirect_to root_path, notice: "Reminder successfully removed"
  end
end
