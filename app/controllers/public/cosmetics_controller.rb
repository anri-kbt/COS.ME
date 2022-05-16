class Public::CosmeticsController < ApplicationController
  def new
    @cosmetic = Cosmetic.new
    #@brand = Brand.new
  end

  def create
    @cosmetic = Cosmetic.new(cosmetic_params)
    @cosmetic.customer_id = current_customer.id
    brand_params_name = params['brand_name']
    brand = Brand.find_by(brand_name: brand_params_name)
    if brand.nil?
      new_brand = Brand.new(brand_name: brand_params_name)
      new_brand.save
      @cosmetic.brand_id = new_brand.id
    else
      @cosmetic.brand_id = brand.id
    end
    if @cosmetic.save!
       redirect_to cosmetics_path ,notice: "新しいコスメを投稿しました"
    else
      render :new
    end
  end

  def category
    @category = Cosmetic.find_by(category_id: params[:category_id])
    @cosmetics = Cosmetic.category
  end

  def index
    @customer = current_customer
    @cosmetics = Cosmetic.all.order(created_at: :desc)
    @categories = Category.all
    if params[:category_id].present?
      #presentメソッドでparams[:category_id]に値が含まれているか確認 => trueの場合下記を実行
      @category = Category.find(params[:category_id])
      @cosmetics = @category.cosmetics
    end
  end

  def show
    @cosmetic = Cosmetic.find(params[:id])
    @cosme_comment = CosmeComment.new
    @cosme_comments=CosmeComment.all
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

  def search
    if params[:keyword].present?
      @cosmetics = Cosmetic.where('cosmetic LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @cosmetics = Cosmetic.all
    end
  end

  def destroy
    @cosmetic.find(params[:id])
    @cosmetic.destroy
    redirect_to cosmetics_path
  end

  private
  def cosmetic_params
    params.require(:cosmetic).permit(:cosmetic_name,:cosmetic_image,:introduction,:price,:public_status,:evaluation,:category_id)
  end

  def brand_params
    params.require(:cosmetic).permit(:brand_name)
  end
end
