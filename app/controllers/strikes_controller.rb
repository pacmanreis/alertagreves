class StrikesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :search]
  before_action :check_if_admin, only: [:new, :create, :destroy, :update, :edit, :approval]

  def index
    @sectors = Sector.all
    @reminder = Reminder.new
    
    if params[:category_id] && params[:category_id] != "all"
      @strikes = policy_scope(Strike).where("start_date >= :date AND category_id = :category_id",
                                            date: Date.today, category_id: params[:category_id]).order(:start_date)
    else
      @strikes = policy_scope(Strike).where("start_date >= :date",
                                            date: Date.today).order(:start_date)
    end
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
