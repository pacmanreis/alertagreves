class SubmittedStrikesController < ApplicationController
  before_action :check_if_admin, only: [:index]

  def index
    @strikes = policy_scope(SubmittedStrike).where("status = 'Pending'").order(:start_date)
  end

  def new
    @submitted_strike = SubmittedStrike.new
    authorize @submitted_strike
  end

  def create
    @submitted_strike = SubmittedStrike.new(submitted_strike_params)
    authorize @submitted_strike
    if @submitted_strike.save
      flash[:notice] = t(:sub_strike_approval)
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @submitted_strike = SubmittedStrike.find(params[:id])
    authorize @submitted_strike
  end

  def update
    @submitted_strike = SubmittedStrike.find(params[:id])
    authorize @submitted_strike
    @submitted_strike.update(submitted_strike_params)
    redirect_to submitted_strikes_path
  end

  def destroy
    @strike = SubmittedStrike.find(params[:id])
    authorize @strike
    @strike.destroy
    redirect_to root_path
  end

  private

  def submitted_strike_params
    if params[:submitted_strike][:name].blank?
      params.require(:submitted_strike).permit(:category_id,
                                    :organization,
                                    :user_id,
                                    :description,
                                    :start_date,
                                    :end_date)
    else
      params.require(:submitted_strike).permit(:category_id,
                                    :organization,
                                    :user_id,
                                    :description,
                                    :start_date,
                                    :end_date)
    end
  end

  def check_if_admin
    redirect_to root_path, alert: "dont be a jerk" unless current_user.admin
  end
end
