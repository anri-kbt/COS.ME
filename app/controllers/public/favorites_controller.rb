class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  def create
    @cosmetic = Cosmetic.find(params[:cosmetic_id])
    favorite = current_customer.favorites.new(cosmetic_id: @cosmetic.id)
    favorite.save
  end

  def destroy
    @cosmetic = Cosmetic.find(params[:cosmetic_id])
    favorite = current_customer.favorites.find_by(cosmetic_id: @cosmetic.id)
    favorite.destroy
  end
end