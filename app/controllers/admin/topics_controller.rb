class Admin::TopicsController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin

  layout "admin"

  def index
    @toics = Topic.all
    @categories = Category.all

    if params[:cid]
      @category = Category.find(params[:cid])
    else
      @category = Category.new
    end
  end

  protected

  def check_admin
    unless current_user.admin?
      raise ActiveRecord::RecordNotFound
      redirect_to root_path
    end

  end

end
