class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  
  def index
    @customers = Customer.page(params[:page])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def update
    @customer=Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customers_path, notice: "ユーザー情報を更新しました"
    else
      render "edit"
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:nickname, :user_id, :call_number,:email,:is_deleted)
  end
end
