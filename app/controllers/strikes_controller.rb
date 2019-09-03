class StrikesController < ApplicationController
  def index
    # @strikes = Strike.all
    @strikes = policy_scope(Strike)
  end

  def new
    @strike = Strike.new
    @union = Union.new
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

  private

  def strike_params
    params.require(:strike).permit(:sector_id,
                                   :category_id,
                                   :union_id,
                                   :organization,
                                   :description,
                                   :start_date,
                                   :end_date)
  end
end
