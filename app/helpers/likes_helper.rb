module LikesHelper

  def person_like_convert(number)
    if number > 1
      "#{pluralize(number, "person")} like this topic"
    else
      "#{pluralize(number, "person")} likes this topic"
    end
  end

end
