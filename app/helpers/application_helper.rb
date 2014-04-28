module ApplicationHelper
  def fix_url(str)
    if str.starts_with?("http://")
      str
    else
      "http://#{str}"
    end    
  end

  def display_datetime(dt)
    dt.strftime("%d/%m/%y at %l:%M%p")
  end
end
