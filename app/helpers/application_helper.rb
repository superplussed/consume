module ApplicationHelper
  def time_ago date
    time_ago_in_words(date).gsub("about", "").strip if date.present?
  end
end
