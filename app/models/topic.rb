class Topic < ActiveRecord::Base
  validates_presence_of :title

  has_many :comments, :dependent => :destroy
  belongs_to :user

  has_many :topic_category_relationships
  has_many :categories, :through => :topic_category_relationships

  has_many :user_topic_favorites
  #has_many :users, :through => :user_topic_favorites
  # TODO 3
  # Rename method and find users through this relationship
  has_many :favorite_users, :through => :user_topic_favorites, :source => :user

  has_attached_file :pic, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :pic, content_type: /\Aimage\/.*\Z/

  has_many :subscriptions
  has_many :subscribed_users, :through => :subscriptions, :source => :user


  def has_comment?
    # TODO 2
    # Implement this method
    if self.comments_count == 0
      false
    else
      true
    end
  end

  def find_my_subscription(user)
    self.subscriptions.where(:user=> user).first
  end

end
