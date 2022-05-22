class Public::CalendarsController < ApplicationController
  def index
    @calendars = Calendar.where(customer_id: current_customer.id).includes(:customer)
    @cosmetics = Cosmetic.where(customer_id: current_customer.id).includes(:customer)
    #dt = params[:month].to_date
    @dates = (Date.new(Date.today.year,Date.today.month, 1)...Date.new(Date.today.year,Date.today.month + 1, 1)).to_a
    #month = params[:month].to_date
    #calendar = Calendar.where(used_date: month..month.end_of_month)
    #@month_cosme = Cosmetic.calendar.where(customer_id: current_customer.id)

    #その月に使ったcosmeticsのデータをすべて取ってくる
    @calendar = Calendar.where(used_date: Time.current.all_month, customer_id: current_customer.id)
    @hash = Hash.new
    #@datesを回して取ってきたcosmeticsのカレンダーのused_dateのデータが存在しているどうかをチェック
    @dates.each do |d|
      @calendar.each_with_index do |c,i|
        if c.used_date.to_date == d
          @hash[d] = c.cosmetics[i]
        end
      end
    end
    #Hashを宣言する
    #HashにDateのキーを用意する
    #各日付のキーに対してcosmeticsが存在していればそのデータを、存在していなければ空の配列を入れる
    #その内容を@変数でビューに渡す


    if params[:month].present?
      dt = params[:month].to_date
      @dates = (Date.new(dt.year,dt.month, 1)...Date.new(dt.year,dt.month + 1, 1)).to_a
      #search_date = params[:month]
      #@month_calendar = Calendar.where(used_date: search_date.in_time_zone.all_month)
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
