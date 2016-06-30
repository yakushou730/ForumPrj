class TopicCommentsController < ApplicationController

  before_action :set_topic

  def new
    @comment = @topic.comments.new
  end

  def edit
  end

  def create
    @comment = @topic.comments.new(comment_param)
    @comment.user = current_user
    if @comment.save
      @topic.comment_last_updated_at = @comment.updated_at
      @topic.save
      flash[:notice] = "create success"

      respond_to do |format|
        format.html {redirect_to topic_path(@topic)}
        format.js
      end


    else
      #redirect_to topic_path(@topic)
      #render 'new'

      # 以下這段有疑慮
      # Q1 : 和 topic的show action重複性太高，可是不加的話重新render topic show頁面會壞掉

      # 隱藏不是自己的draft評論
      if current_user
        @comments = @topic.comments.where("user_id = ? or status = ?", current_user.id, "release").order("updated_at desc")
      else
        @comments = @topic.comments.where(:status => "release").order("updated_at desc")
      end

      # 讀取這篇文章是否已經被此使用者收藏
      @is_favorite = UserTopicFavorite.where(:user_id => current_user.id, :topic_id => @topic.id).count == 0 ? false : true

      @subscription = @topic.find_my_subscription(current_user)

      @like = @topic.find_my_like(current_user)

      render 'topics/show'
    end
  end

  def edit

    @comment = @topic.comments.find(params[:id])
    if @comment.user != current_user
      flash[:alert] = "you cannot EDIT others' comments"
      redirect_to topic_path(@topic)
    end

  end

  def update

    @comment = @topic.comments.find(params[:id])

    if params[:_remove_pic] == "1"
        @comment.pic = nil
    end

    if @comment.update(comment_param)
      @topic.comment_last_updated_at = @comment.updated_at
      @topic.save
      flash[:notice] = "update success"

      respond_to do |format|
        format.html {redirect_to topic_path(@topic)}
        format.js
      end

    else

      # 以下這段有疑慮
      # Q1 : 和 topic的show action重複性太高，可是不加的話重新render topic show頁面會壞掉

      # 隱藏不是自己的draft評論
      if current_user
        @comments = @topic.comments.where("user_id = ? or status = ?", current_user.id, "release").order("updated_at desc")
      else
        @comments = @topic.comments.where(:status => "release").order("updated_at desc")
      end

      # 讀取這篇文章是否已經被此使用者收藏
      @is_favorite = UserTopicFavorite.where(:user_id => current_user.id, :topic_id => @topic.id).count == 0 ? false : true

      @subscription = @topic.find_my_subscription(current_user)

      @like = @topic.find_my_like(current_user)

      render 'topics/show'
      #render 'edit'
    end
  end

  def destroy

    if @topic.user != current_user

      flash[:alert] = "you cannot DESTROY others' comments"

      redirect_to topic_path(@topic)

    else

      @comment = @topic.comments.find(params[:id])

      @comment.destroy

      if @topic.comments_count > 1
        # 1要砍成0，但在此時暫存還是1
        @topic.comment_last_updated_at = Comment.order("updated_at").last.updated_at
      else
        @topic.comment_last_updated_at = nil
      end
      @topic.save

      flash[:alert] = "delete success"

      @new_comment = Comment.new

      respond_to do |format|
        format.html {redirect_to topic_path(@topic)}
        format.js
      end
    end

  end

  protected

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def comment_param
    params.require(:comment).permit(:content, :pic, :status)
  end


end
