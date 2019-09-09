class StrikesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :search]
  before_action :check_if_admin, only: [:new, :create, :destroy, :update, :edit, :approval]

  def index
    @ongoing = Strike.where(start_date: Date.today - 100..Date.today)
                     .where(end_date: Date.today..Date.today + 100).order(:end_date)
    @tomorrow = policy_scope(Strike).where(start_date: Date.tomorrow).order(:start_date)
    @this_week = Strike.where(start_date: Date.tomorrow.beginning_of_week..Date.tomorrow.end_of_week).order(:start_date) - @tomorrow - @ongoing
    @next_week = Strike.where(start_date: Date.today.beginning_of_week.next_week..Date.today.end_of_week.next_week).order(:start_date)
    @following = Strike.where(start_date: Date.today.beginning_of_week.next_week.next_week..Date.today + 100).order(:start_date)

    @reminder = Reminder.new
  end

  def new
    @strike = Strike.new
    @strike.build_union
    authorize @strike
  end

  def create
    @strike = Strike.new(strike_params)
    authorize @strike
    if @strike.save
      redirect_to root_path
    else
      @strike.build_union
      render :new
    end
  end

  def approval
    @sub_strike = SubmittedStrike.find(params[:id])
    @strike = Strike.new(organization: @sub_strike.organization,
                         description: @sub_strike.description,
                         category: @sub_strike.category,
                         union: @sub_strike.union,
                         start_date: @sub_strike.start_date,
                         end_date: @sub_strike.end_date)
    authorize @strike
    @strike.save
    @sub_strike.update(status: 'Approved')
    redirect_to submitted_strikes_path
  end

  def search
    @strikes = Strike.search_by_country_organization_description_and_union_id(params[:query])
    @reminder = Reminder.new
    authorize @strikes
  end

  def show
    @strike = Strike.find(params[:id])
    authorize @strike
  end

  def destroy
    @strike = Strike.find(params[:id])
    authorize @strike
    @strike.destroy
    redirect_to root_path
  end

  def edit
    @strike = Strike.find(params[:id])
    authorize @strike
    @union = Union.new
  end

  def update
    @strike = Strike.find(params[:id])
    authorize @strike
    @strike.update(strike_params)
    redirect_to root_path
  end

  private

  def strike_params
    if params[:strike][:union_attributes][:name].blank?
      params.require(:strike).permit(:category_id,
                                    :organization,
                                    :description,
                                    :start_date,
                                    :end_date,
                                    :union_id)
    else
      params.require(:strike).permit(:category_id,
                                    :organization,
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
