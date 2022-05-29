class Admin::CosmeticsController < ApplicationController

  def index
    @cosmetics = Cosmetic.all.order(created_at: :desc).all.page(params[:page]).per(12)
    @categories = Category.all
    if params[:category_id].present?
      #presentメソッドでparams[:category_id]に値が含まれているか確認 => trueの場合下記を実行
      @category = Category.find(params[:category_id])
      @cosmetics = Cosmetic.all.page(params[:page]).per(12)
    end
  end

  def show
    @cosmetic = Cosmetic.find(params[:id])
  end

  def destroy
    @cosmetic = Cosmetic.find(params[:id])
    @cosmetic.destroy
    redirect_to admin_cosmetics_path,notice:"投稿を削除しました"
  end
end
