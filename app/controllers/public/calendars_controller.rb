class Public::CalendarsController < ApplicationController
  before_action :authenticate_customer!
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  def index
    @calendars = Calendar.where(customer_id: current_customer.id).includes(:customer)
    @cosmetics = Cosmetic.where(customer_id: current_customer.id).includes(:customer)
    @dates = (Date.new(Date.today.year,Date.today.month, 1)...Date.new(Date.today.year,Date.today.month + 1, 1)).to_a

    @calendar = Calendar.where(used_date: Time.current.all_month, customer_id: current_customer.id).index_by { |e| e.used_date.strftime("%y-%m-%d") }

    if params[:month].present?
      dt = params[:month].to_date
      @dates = (Date.new(dt.year,dt.month, 1)...Date.new(dt.year,dt.month + 1, 1)).to_a
    end
  end

  def new
    day = params[:used_date]
    @calendar = Calendar.new
    @calendar.used_date = day
    @cosmetics = Cosmetic.where(customer_id: current_customer.id)
  end

  def create
    @calendar = Calendar.new(calendar_params)
    @cosmetic_ids = params[:calendar][:cosmetic_ids]
    @cosmetics = Cosmetic.where(customer_id: current_customer.id).includes(:customer)
    @calendar.customer_id = current_customer.id
    @cosmetic_ids.shift
      @cosmetic_ids.each do |cosmetic_id|
      cosmetic = Cosmetic.find(cosmetic_id.to_i)
      #@calendar.cosmetic_id = cosmetic_id
      end
    if @calendar.save!
      redirect_to calendars_path,notice:"カレンダーを追加しました"
    else
      redirect_to new_calendar_path,notice:"カレンダーを追加できませんでした"
    end
  end

  def edit
    @calendar = Calendar.find(params[:id])
    @cosmetics=Cosmetic.where(customer_id: current_customer.id)
  end

  def update
    @calendar = Calendar.find(params[:id]).update(calendar_params)
    redirect_to calendars_path, notice:"カレンダーを更新しました"
  end

  def destroy
    @calendar = Calendar.find(params[:id])
    @calendar.destroy
    redirect_to calendars_path(@calendar.id), notice:"カレンダーを削除しました"
  end

  private

  def calendar_params
    params.require(:calendar).permit(:used_date,:customer_id,cosmetic_ids:[])
  end
end
