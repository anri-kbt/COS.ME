class Public::CustomersController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?
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
      redirect_to customers_path ,notice: "登録情報を更新しました"
    else
      render "show"
    end
  end

  def mycosmetics
    @customer = current_customer
    @cosmetics = Cosmetic.where(customer_id: current_customer.id).includes(:customer).order("created_at DESC")
    @categories = Category.all
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
    params.require(:customer).permit(:nickname,:user_id ,:call_number,:email)
  end
end
