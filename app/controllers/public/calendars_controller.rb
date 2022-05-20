class Public::CalendarsController < ApplicationController
  def index
    @cosmetics = Cosmetic.where(customer_id: current_customer.id).includes(:customer)
    @dates = (Date.new(Date.today.year,Date.today.month, 1)...Date.new(Date.today.year,Date.today.month + 1, 1)).to_a
    @cosmetics = current_customer.cosmetics
   # @months = (Date.new(Date.today.month,1)...Date.new(Date.today.month + 1, 1)).to_a
    #@this_month = Date.today.month

    #@month_1 = Date.today.beginning_of_year.month
    #@month_12 = Date.today.end_of_year.month
    search_date = params[:month]
    @month_calendar = Calendar.where(used_date: search_date.in_time_zone.all_month)
    if params[:month].present?
      @month_calendar = Calendar.find(params[:month])
      @cosmetics = @category.cosmetics
    end
  end

  def new
    day = params[:used_date]
    @calendar=Calendar.new
    @calendar.used_date = day
    @cosmetics=Cosmetic.where(customer_id: current_customer.id)
  end

  def create
    @calendar = Calendar.new(calendar_params)
    @cosmetic_ids = params[:calendar][:cosmetic_ids]
    @cosmetics = Cosmetic.where(customer_id: current_customer.id).includes(:customer)
    @calendar.customer_id = current_customer.id
    @cosmetic_ids.shift
      @cosmetic_ids.each do |cosmetic_id|
      cosmetic = Cosmetic.find(cosmetic_id.to_i)
      @calendar.cosmetic_id = cosmetic_id
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

  private

  def calendar_params
    params.require(:calendar).permit(:used_date,:customer_id,cosmetic_ids:[])
  end
end
