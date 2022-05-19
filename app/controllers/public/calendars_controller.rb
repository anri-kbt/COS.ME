class Public::CalendarsController < ApplicationController
  def index
    @cosmetics = Cosmetic.where(customer_id: current_customer.id).includes(:customer)
    @dates = (Date.new(Date.today.year,Date.today.month, 1)...Date.new(Date.today.year,Date.today.month + 1, 1)).to_a
    @cosmetics =current_customer.cosmetics
    #calendar = Calendar.find(params[:id])
  end

  def new
    @calendar=Calendar.new
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
    binding.pry
    @calendar = Calendar.find(params[:id])
  end

  private

  def calendar_params
    params.require(:calendar).permit(:used_date,:customer_id,cosmetic_ids:[])
  end
end
