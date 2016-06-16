class Topic < ActiveRecord::Base
  validates_presence_of :title

  has_many :comments, :dependent => :destroy
  belongs_to :user

  has_many :topic_category_relationships
  has_many :categories, :through => :topic_category_relationships

  has_many :user_topic_favorites
  has_many :users, :through => :user_topic_favorites
end
