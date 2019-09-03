class StrikesController < ApplicationController
  def new
    @strike = Strike.new
  end

  def show
    @strike = Strike.find(params[:id])
  end
end
