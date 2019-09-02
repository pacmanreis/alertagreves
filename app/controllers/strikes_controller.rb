class StrikesController < ApplicationController
  def show
    @strike = Strike.find(params[:id])
  end
end
