class LikesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_topic

  def create

    @like = @topic.find_my_like(current_user)

    unless @like
      @like = Like.create(:topic => @topic, :user => current_user)
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end

  end

  def destroy

    @like = @topic.likes.find(params[:id])
    @like.destroy
    @like = nil

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end

  end

  protected

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

end
