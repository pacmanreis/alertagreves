class StrikesController < ApplicationController

  def index
    @strikes = Strike.all
  end

  def new
    @strike = Strike.new
    @union = Union.new
  end

  def show
    @strike = Strike.find(params[:id])
  end
end
