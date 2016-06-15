class User < ActiveRecord::Base

  include Gravtastic
  gravtastic

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :topics, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  def short_name
    self.email.split("@").first
  end

end
