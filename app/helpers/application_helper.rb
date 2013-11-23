module ApplicationHelper

  def friendly date
    date.strftime("%b %d, %r")
  end
end
