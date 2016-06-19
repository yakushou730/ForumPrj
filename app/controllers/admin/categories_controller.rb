class Admin::CategoriesController < ApplicationController

  before_action :set_category, :only => [:edit, :update, :destroy]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_param)
    if @category.save
      flash[:notice] = "create success"
      redirect_to admin_topics_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @category.update(category_param)
      flash[:notice] = "update success"
      redirect_to admin_topics_path
    else
      redner 'edit'
    end
  end

  def destroy

    # 直接用 @category.topics.count ?
    topic_count = TopicCategoryRelationship.where(:category_id => params[:id]).count

    if topic_count > 0
      flash[:alert] = "cannot delete, some topic use this category"
      redirect_to admin_topics_path
    else
      @category.destroy
      flash[:alert] = "delete success"
      redirect_to admin_topics_path
    end


  end

  protected

  def set_category
    @category =Category.find(params[:id])
  end

  def category_param
    params.require(:category).permit(:name)
  end

end
