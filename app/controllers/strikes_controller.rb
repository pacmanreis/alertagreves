class StrikesController < ApplicationController
  def index
    @strikes = Strike.all
  end

  def new
    @strike = Strike.new
  end

  def show
    @strike = Strike.find(params[:id])
  end

  def destroy
    @strike = Strike.find(params[:id])
    @strike.destroy
  end
end
