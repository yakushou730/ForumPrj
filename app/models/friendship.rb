class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => "User"

  def is_request?
    self.status == "request"
  end

  def is_accept?
    self.status == "accept"
  end

end
