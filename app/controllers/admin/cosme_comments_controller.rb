class Admin::CosmeCommentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  def destroy
    p params
    CosmeComment.find_by(id: params[:comment_id], cosmetic_id: params[:cosmetic_id]).destroy
    redirect_to request.referer
  end

end
