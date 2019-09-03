class UnionsController < ApplicationController

  def create
    @union = Union.new(union_params)
    @union.save

    redirect_to new_strike_path
  end

  private

  def union_params
    params.require(:union).permit(:name, :initials, :url)
  end
end
