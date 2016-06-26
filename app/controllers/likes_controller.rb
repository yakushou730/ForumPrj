class LikesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_topic

  def create
    Like.create(:topic => @topic, :user => current_user)

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end

  end

  def destroy

    like = @topic.likes.find(params[:id])
    like.destroy

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
