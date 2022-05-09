class Public::CosmeticsController < ApplicationController
  def new
    @cosmeticS = Cosmetics.all
  end

  def index
  end

  def show
  end

  def edit
  end
end
