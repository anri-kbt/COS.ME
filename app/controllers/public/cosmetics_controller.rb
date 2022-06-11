class Public::CosmeticsController < ApplicationController
  before_action :authenticate_customer!, except:[:index, :category, :show, :search]
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  def new
    @cosmetic = Cosmetic.new
  end

  def create
    @cosmetic = Cosmetic.new(cosmetic_params)
    @cosmetic.customer_id = current_customer.id
    brand_params_name = params['brand_name']
    brand = Brand.find_by(brand_name: brand_params_name)
    if brand.nil? #ブランド名がDBになかったら、新しくidを取得して保存
      new_brand = Brand.new(brand_name: brand_params_name)
      new_brand.save
      @cosmetic.brand_id = new_brand.id
    else
      @cosmetic.brand_id = brand.id  #同じブランド名であれば同じidで保存
    end
    if @cosmetic.save
      if params[:cosmetic][:public_status] == 'public'
        redirect_to cosmetics_path ,notice: "新しいコスメを投稿しました"
      else
        redirect_to mycosmetics_path(current_customer.id),notice: "新しいコスメを投稿しました"
      end
    else
      render :new
    end
  end

  def category
    @category = Cosmetic.find_by(category_id: params[:category_id])
    @cosmetics = Cosmetic.category
  end

  def index
    @cosmetics = Cosmetic.where(public_status: 0).page(params[:page]).per(12)
    @categories = Category.all
    if params[:category_id].present?
      #presentメソッドでparams[:category_id]に値が含まれているか確認 => trueの場合下記を実行
      @category = Category.find(params[:category_id])
      @cosmetics = @category.cosmetics.where(public_status: 0).page(params[:page]).per(12)
    end
  end

  def show
    @cosmetic = Cosmetic.find(params[:id])
    @cosme_comment = CosmeComment.new
    @cosme_comments = CosmeComment.all
  end

  def edit
    @cosmetic = Cosmetic.find(params[:id])
    @brand = Brand.find(@cosmetic.brand.id)
    if @cosmetic.customer==current_customer
      render :edit
    else
      redirect_to cosmetics_path
    end
  end

  def update
    @cosmetic = Cosmetic.find(params[:id])
    brand_params_name = params['brand_name']
    brand = Brand.find_by(brand_name: brand_params_name)
    if brand.nil? #ブランド名がDBになかったら、新しくidを取得して保存
      new_brand = Brand.new(brand_name: brand_params_name)
      new_brand.save
      @cosmetic.brand_id = new_brand.id
    else
      @cosmetic.brand_id = brand.id  #同じブランド名であれば同じidで保存
    end
    if @cosmetic.update(cosmetic_params)
      if params[:cosmetic][:public_status] == 'public'
        redirect_to cosmetics_path ,notice: "コスメレビューを更新しました"
      else
        redirect_to mycosmetics_path(current_customer.id),notice: "コスメレビューを更新しました"
      end
    else
      render "edit"
    end
  end

  def search
    @cosmetics = Cosmetic.where(public_status: 0).page(params[:page]).per(12)
    if params[:keyword].present?
      @cosmetics = Cosmetic.where('cosmetic_name LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @cosmetics = Cosmetic.page(params[:page]).per(12)
    end
  end

  def destroy
    @cosmetic = Cosmetic.find(params[:id])
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
