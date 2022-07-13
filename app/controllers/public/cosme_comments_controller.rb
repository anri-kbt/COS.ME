class Public::CosmeCommentsController < ApplicationController
  before_action :authenticate_customer!
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  def create
    cosmetic = Cosmetic.find(params[:cosmetic_id])
    @comment = CosmeComment.new(cosme_comment_params)
    @comment.customer_id = current_customer.id
    @comment.cosmetic_id = cosmetic.id
    @comment.save
  end

  def destroy
    @cosme_comment = CosmeComment.find(params[:id])
    CosmeComment.find_by(id: params[:id], cosmetic_id: params[:cosmetic_id]).destroy
  end

  private
  def cosme_comment_params
    params.require(:cosme_comment).permit(:comment)
  end
end