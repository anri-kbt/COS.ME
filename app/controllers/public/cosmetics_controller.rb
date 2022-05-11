class Public::CosmeticsController < ApplicationController
  def new
    @cosmetic = Cosmetic.new
  end

  def create
    @cosmetic = Cosmetic.new(cosmetic_params)
    @cosmetic.customer_id = current_customer.id
    if @cosmetic.save!
       redirect_to cosmetics_path ,notice: "新しいコスメを投稿しました"
    else
      render :new
    end
  end

  def index
      # 投稿すべてを取得
      @cosmetics = Cosmetic.all.order(created_at: :desc).all
  end

  def show
    @cosmetic = Cosmetic.find(params[:id])
  end

  def edit
    @cosmetic = Cosmetic.find(params[:id])
    if @cosmetic.customer==current_customer
      render :edit
    else
      redirect_to cosmetics_path
    end
  end

  def update
    @cosmetic = Cosmetic.find(params[:id])
    if @cosmetic.update(cosmetic_params)
      redirect_to cosmetic_path(@cosmetic.id) ,notice: "商品情報を更新しました"
    else
      render "edit"
    end
  end

  private
  def cosmetic_params
    params.require(:cosmetic).permit(:cosmetic_name,:cosmetic_image,:introduction,:price,:public_status,:evaluation, brand_attributes: [:id, :brand_name,:_destroy],category_attributes: [:id, :category_name,:_destroy])
  end
end
