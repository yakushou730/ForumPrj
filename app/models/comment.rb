class Comment < ActiveRecord::Base

  validates_presence_of :content

  belongs_to :topic, :counter_cache => true, :touch => true
  belongs_to :user

  has_attached_file :pic, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :pic, content_type: /\Aimage\/.*\Z/

end
