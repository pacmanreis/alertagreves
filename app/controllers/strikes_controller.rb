class StrikesController < ApplicationController
  def index
    # @strikes = Strike.all
    @strikes = policy_scope(Strike)
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
      render :new
    end
  end

  def search
    @strike = Strike.search_by_country_organization_description_and_union_id(params[:query])
    authorize @strike
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
    redirect_to strike_path(@strike)
  end

  private

  def strike_params
    unless (params.require(:strike).has_key?(:union_attributes))
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
end
