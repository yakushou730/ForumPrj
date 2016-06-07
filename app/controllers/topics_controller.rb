class TopicsController < ApplicationController

  before_action :set_topic, :only => [:show, :edit, :update, :destroy]

  def index
    @topics = Topic.all
  end

  def show
    @topic.clicked += 1
    @topic.save
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

  protected

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title, :content, :clicked)
  end
end
