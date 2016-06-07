class TopicCommentsController < ApplicationController

  before_action :set_topic

  def new
    @comment = @topic.comments.new
  end

  def edit
  end

  def create
    @comment = @topic.comments.new(comment_param)
    if @comment.save
      flash[:notice] = "create success"
      redirect_to topic_path(@topic)
    else
      render 'new'
    end
  end

  def edit
    @comment = @topic.comments.find(params[:id])
  end

  def update

    @comment = @topic.comments.find(params[:id])

    if @comment.update(comment_param)
      flash[:notice] = "update success"
      redirect_to topic_path(@topic)
    else
      render 'edit'
    end
  end

  def destroy

    @comment = @topic.comments.find(params[:id])

    @comment.destroy

    flash[:alert] = "delete success"

    redirect_to topic_path(@topic)

  end

  protected

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def comment_param
    params.require(:comment).permit(:content)
  end


end
