class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.new(:friend_id => params[:friend_id], :status => "request")
    @friendship.save

    @profile = User.find(params[:friend_id])
    @be_friend = current_user.friendships.find_by_friend_id(@profile.id)
    respond_to do |format|
      format.html {redirect_to info_profile_path(@profile.short_name)}
      format.js
    end
  end

  def accept
    @friendship = current_user.inverse_friendships.find_by(:user_id=>params[:id])
    @friendship.update(:status => "accept")

    respond_to do |format|
      format.html {redirect_to topics_path}
      format.js
    end
  end

  def cancel
    @friendship = current_user.inverse_friendships.find_by(:user_id=>params[:id])
    @friendship.destroy

    respond_to do |format|
      format.html {redirect_to topics_path}
      format.js
    end
  end

  def destroy
    @friendship = current_user.friendships.find_by_friend_id(params[:friend_id])
    @friendship.destroy

    @profile = User.find(params[:friend_id])
    @be_friend = current_user.friendships.find_by_friend_id(@profile.id)
    respond_to do |format|
      format.html {redirect_to info_profile_path(@profile.short_name)}
      format.js
    end
  end

end
