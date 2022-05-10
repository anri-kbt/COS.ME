class Public::CosmeticsController < ApplicationController
  def new
    @cosmetic = Cosmetic.new
  end

  def create
    @cosmetic = Cosmetic.new(cosmetic_params)
    if @cosmetic.save
      redirect_to cosmetic_path(@cosmetic.id), notice: "新しいコスメを投稿しました"
    else
      @cosmetic = Cosmetic.all
      @customer=current_customer
      render 'index'
    end
  end

  def index
  end

  def show
  end

  def edit
  end

  private
  def cosmetic_params
    params.require(:cosmetic).permit(:cosmetic_name,:cosmetic_image,:introduction,:price,:public_status, cosmetic_attributes: [:id, :brand_name,:category_name])
  end
end
