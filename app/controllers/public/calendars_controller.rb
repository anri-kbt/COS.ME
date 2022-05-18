class Public::CalendarsController < ApplicationController
  def index
   # @today = Date.today
    #from_date = Date.new(@today.year, @today.month, @today.beginning_of_month.day).beginning_of_week(:sunday)
    #to_date = Date.new(@today.year, @today.month, @today.end_of_month.day).end_of_week(:sunday)
    #@calendar_data = from_date.upto(to_date)
  end

  def new
    @calendar=Calendar.new
    @cosmetics=Cosmetic.where(customer_id: current_customer.id)
  end

  def create
    binding.pry
    @calendar = Calendar.new(calendar_params)
    @cosmetic_ids=params[:calendar][:cosmetic_ids]
    @cosmetics = Cosmetic.where(customer_id: current_customer.id).includes(:customer)
    @calendar.customer_id = current_customer.id
    if @calendar.save!
        @cosmetic_ids.each do |cosmetic_id|
        cosmetic=Cosmetic.find(cosmetic_id.to_i)
        @calendar.cosmetics << cosmetic
      end
      redirect_to calendars_path,notice:"カレンダーを追加しました"
    else
      redirect_to new_calendar_path,notice:"カレンダーを追加できませんでした"
    end
  end

  def edit
  end

  private

  def calendar_params
    params.require(:calendar).permit(:used_date,:customer_id,cosmetic_ids:[])
  end
end
