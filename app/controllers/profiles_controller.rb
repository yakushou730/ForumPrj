class ProfilesController < ApplicationController

  def info
    @profile = User.find(params[:id])
    @topics = Topic.where("user_id = #{params[:id]}")
    @comments = Comment.where("user_id = #{params[:id]}")

    favorite_topic_ids = []
    favorite_topics = UserTopicFavorite.where(:user_id=> params[:id])

    @favorites = []
    favorite_topics.each do |favorite_topic|
      @favorites << Topic.find(favorite_topic.topic_id)
    end

    # favorite_topics.each do |t|
    #   favorite_topic_ids << t.topic_id
    # end

    # @user_favorite_topics = []

    # favorite_topic_ids.each do |id|
    #   @user_favorite_topics << Topic.find(id)
    # end

  end

end
