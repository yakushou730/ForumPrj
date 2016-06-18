class Category < ActiveRecord::Base

  validates_presence_of :name

  has_many :topic_category_relationships
  has_many :topics, :through => :topic_category_relationships
end
