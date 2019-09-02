class StrikesController < ApplicationController
  def new
    @strike = Strike.new
  end
end
