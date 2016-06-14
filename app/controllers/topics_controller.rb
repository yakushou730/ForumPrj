class TopicsController < ApplicationController

  before_action :authenticate_user!, :except => [:index]
  before_action :set_topic, :only => [:show, :edit, :update, :destroy]

  def index

    # 依照分類篩選文章(預留)
    if params[:sort] && params[:sort] == "sports"
      @topics = Category.find_by(:name => "Sports").topics
    elsif params[:sort] && params[:sort] == "boardgame"
      @topics = Category.find_by(:name => "BoardGame").topics
    elsif params[:sort] && params[:sort] == "love"
      @topics = Category.find_by(:name => "Love").topics
    elsif params[:sort] && params[:sort] == "action"
      @topics = Category.find_by(:name => "Action").topics
    else
      # 目前預設排序為文章update時間
      @topics = Topic.all #.order("updated_at desc")
      #@topics = Topic.all.order("comment_last_updated_at desc")
    end

    if params[:order]
      if params[:order] == "last_comment_time"
        @topics = Topic.all.order("comment_last_updated_at desc")
      elsif params[:order] && params[:order] == "comment_number"
        @topics = Topic.all.order("comments_count desc")
      elsif params[:order] && params[:order] == "topic_clicks"
        @topics = Topic.all.order("clicked desc")
      end
    end

    params_for_page

    @categories = Category.all

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

  def params_for_page
    @topics = @topics.page(params[:page]).per(5)
  end
end
