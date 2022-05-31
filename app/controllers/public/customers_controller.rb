class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :ensure_guest_customer, only: [:edit]
  protect_from_forgery with: :exception

  def index
  end

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
    if @customer == current_customer
      render :edit
    else
      redirect_to root_path
    end
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_path(current_customer) ,notice: "登録情報を更新しました"
    else
      render "show"
    end
  end

  #def category
   # @category = Cosmetic.find_by(category_id: params[:category_id])
  #  @cosmetics = Cosmetic.category
  #end

  def mycosmetics
    @customer = Customer.find(params[:id])
    if @customer.id == current_customer.id
      @customer = current_customer
      @cosmetics = Cosmetic.where(customer_id: current_customer.id).includes(:customer).order("created_at DESC")
      @categories = Category.all
      #category.cosmetics = Category.cosmetics.where(customer_id: current_customer.id)
    else
      @customer = Customer.find(params[:id])
      @cosmetics = Cosmetic.where(customer_id: @customer.id, public_status: 0).includes(:customer).order("created_at DESC")
      @categories = Category.all
    end

    if params[:category_id].present?
      #presentメソッドでparams[:category_id]に値が含まれているか確認 => trueの場合下記を実行
      @category = Category.find(params[:category_id])
      @cosmetics = @category.cosmetics
    end
  end

  def withdrawal
    @customer = current_customer
  end

  def out
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path ,notice: "アカウントを削除しました"
  end

  private

  def customer_params
    params.require(:customer).permit(:nickname,:user_id ,:call_number,:email,:profile_image)
  end

  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.nickname == "guestcustomer"
      redirect_to customer_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません'
    end
  end
end
