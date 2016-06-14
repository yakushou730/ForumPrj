class TopicsController < ApplicationController

  before_action :authenticate_user!, :except => [:index]
  before_action :set_topic, :only => [:show, :edit, :update, :destroy]

  def index

    # 目前預設排序為文章update時間
    @topics = Topic.all.order("updated_at desc")
    #@topics = Topic.all.order("comment_last_updated_at desc")

    if params[:order] && params[:order] == "last_comment_time"
      # Need to order by last comment time
      @topics = Topic.all.order("comment_last_updated_at desc")
    elsif params[:order] && params[:order] == "comment_number"
      # Need to order by most comment number
      @topics = Topic.all.order("comments_count desc")
    end

    @category = Category.all

  end

  def show
    @topic.clicked += 1
    @topic.save

    @comments = @topic.comments.order("updated_at desc")
  end

  def destroy
    @topic.destroy
    flash[:alert] = "delete success"
    redirect_to topics_path
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user
    if @topic.save
      flash[:notice] = "create success"
      redirect_to topics_path
    else
      render "new"
    end
  end

  def edit

  end

  def update
    if @topic.update(topic_params)
      flash[:notice] = "update success"
      redirect_to topics_path
    else
      render "edit"
    end

  end

  def about
    @users = User.all
    @topics = Topic.all
    @comments = Comment.all
  end

  protected

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title, :content, :clicked, :category_ids => [])
  end
end
