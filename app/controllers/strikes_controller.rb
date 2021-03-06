class StrikesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :search, :mobile_filter, :calendar, :search, :about_us, :show]
  before_action :check_if_admin, only: [:new, :create, :destroy, :update, :edit, :approval]

  def index
    @categories = Category.all

    @grouped_strikes = {
      ongoing: ongoing,
      tomorrow: tomorrow,
      this_week: this_week - ongoing - tomorrow,
      next_week: next_week - tomorrow,
      following: following
    }

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @strike = Strike.new
    authorize @strike
  end

  def create
    @strike = Strike.new(strike_params)
    authorize @strike
    if @strike.save
      redirect_to root_path
    else
      render :new
    end
  end

  def approval
    @sub_strike = SubmittedStrike.find(params[:id])
    @strike = Strike.new(organization: @sub_strike.organization,
                         description: @sub_strike.description,
                         category: @sub_strike.category,
                         start_date: @sub_strike.start_date,
                         end_date: @sub_strike.end_date)
    authorize @strike
    @strike.save
    @sub_strike.update(status: 'Approved')
    redirect_to submitted_strikes_path
  end

  def search
    @strikes = Strike.order(end_date: :desc).search_by_country_organization_description_and_union_id(params[:query])
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
  end

  def update
    @strike = Strike.find(params[:id])
    authorize @strike
    @strike.update(strike_params)
    redirect_to root_path
  end

  def calendar
    @strikes = Strike.all
    authorize @strikes
  end

  def mobile_filter
    @categories = policy_scope(Category)
  end

  def about_us
    @strikes = Strike.all
    authorize @strikes
  end

  private

  def category_filter?
    params[:category_id] && params[:category_id] != "all"
  end

  def ongoing
    return @ongoing if @ongoing.present?

    @ongoing = policy_scope(Strike).where(start_date: Date.today - 100..Date.today)
    @ongoing = @ongoing.where(end_date: Date.today..Float::INFINITY)
    @ongoing = @ongoing.where(category_id: params[:category_id]) if category_filter?

    @ongoing.order(:end_date)
  end

  def tomorrow
    return @tomorrow if @tomorrow.present?

    @tomorrow = policy_scope(Strike).where(start_date: Date.tomorrow)
    @tomorrow = @tomorrow.where(category_id: params[:category_id]) if category_filter?

    @tomorrow.order(:start_date)
  end

  def this_week
    return @this_week if @this_week.present?

    date_range = Date.tomorrow..Date.tomorrow.end_of_week
    @this_week = policy_scope(Strike).where(start_date: date_range)
    @this_week = @this_week.where(category_id: params[:category_id]) if category_filter?

    @this_week.order(:start_date)
  end

  def next_week
    return @next_week if @next_week.present?

    date_range = Date.today.beginning_of_week.next_week..Date.today.next_week.end_of_week
    @next_week = policy_scope(Strike).where(start_date: date_range)
    @next_week = @next_week.where(category_id: params[:category_id]) if category_filter?

    @next_week.order(:start_date)
  end

  def following
    date_range = Date.today.beginning_of_week.next_week.next_week..Float::INFINITY
    following = policy_scope(Strike).where(start_date: date_range)
    following = following.where(category_id: params[:category_id]) if category_filter?

    following.order(:start_date)
  end

  def strike_params
    if params[:strike][:name].blank?
      params.require(:strike).permit(:category_id,
                                    :organization,
                                    :description,
                                    :start_date,
                                    :end_date)
    else
      params.require(:strike).permit(:category_id,
                                    :organization,
                                    :description,
                                    :start_date,
                                    :end_date)
    end
  end

  def check_if_admin
    redirect_to root_path, alert: "dont be a jerk" unless current_user.admin
  end
end
