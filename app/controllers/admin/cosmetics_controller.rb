class Admin::CosmeticsController < ApplicationController

  def index
    @cosmetics = Cosmetics.page(params[:page])
  end
end
