class UnionsController < ApplicationController
  def create
    @union = Union.new(union_params)
    @union.save
    authorize @union
    redirect_to new_strike_path
  end

  private

  def union_params
    params.require(:union).permit(:name, :initials, :url)
  end
end
