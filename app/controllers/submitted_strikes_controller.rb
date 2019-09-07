class SubmittedStrikesController < ApplicationController
  before_action :check_if_admin, only: [:index]

  def index
    @strikes = policy_scope(SubmittedStrike).where("status = 'Pending'")
  end

  def new
    @submitted_strike = SubmittedStrike.new
    @submitted_strike.build_union
    authorize @submitted_strike
  end

  def create
    @submitted_strike = SubmittedStrike.new(submitted_strike_params)
    authorize @submitted_strike
    if @submitted_strike.save
      redirect_to root_path
    else
      @submitted_strike.build_union
      render :new
    end
  end

  def destroy
    @strike = SubmittedStrike.find(params[:id])
    authorize @strike
    @strike.destroy
    redirect_to root_path
  end

  private

  def submitted_strike_params
    if params[:submitted_strike][:union_attributes][:name].blank?
      params.require(:submitted_strike).permit(:category_id,
                                    :organization,
                                    :user_id,
                                    :description,
                                    :start_date,
                                    :end_date,
                                    :union_id)
    else
      params.require(:submitted_strike).permit(:category_id,
                                    :organization,
                                    :user_id,
                                    :description,
                                    :start_date,
                                    :end_date,
                                    union_attributes: [:id, :name, :initials, :url])
    end
  end

  def check_if_admin
    redirect_to root_path, alert: "dont be a jerk" unless current_user.admin
  end
end
