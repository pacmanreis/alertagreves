class StrikesController < ApplicationController
  def index
    @strikes = Strike.all
  end
end
