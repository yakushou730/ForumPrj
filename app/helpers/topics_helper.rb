module TopicsHelper

  def make_user_profile_links(user_list)

    # Question : 如果直接用空字串串起來的話會變成字串，而不是標籤

    total_link_tag = String.new
    flag = false
    user_list.each do |user|
      if flag == false
        total_link_tag = link_to(user.values.to_s[2...-2], info_profile_path(user.values)) + "    "
        flag = true
      else
        total_link_tag += link_to(user.values.to_s[2...-2], info_profile_path(user.values)) + "    "
      end

    end
    total_link_tag
  end

end
