class Admin::CosmeticsController < ApplicationController

  def index
    @cosmetics = Cosmetic.all.order(created_at: :desc).all
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
