class Category < ActiveRecord::Base

  has_many :topic_category_relationships
  has_many :topics, :through => :topic_category_relationships
end
