class User < ActiveRecord::Base

  include Gravtastic
  gravtastic

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :topics, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  has_many :user_topic_favorites
  has_many :topics, :through => :user_topic_favorites

  def short_name
    self.email.split("@").first
  end

  def admin?
    self.role == "admin"
  end

  def show_name
    self.short_name || ""
  end

  def isnot_current_user?(log_in_id)
    self.id != log_in_id
  end

end
