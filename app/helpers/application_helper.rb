module ApplicationHelper
  def fix_url(str)
    if str.starts_with?("http://")
      str
    else
      "http://#{str}"
    end    
  end

  def display_datetime(dt)
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
    end
    dt.strftime("%d/%m/%y at %l:%M%p %Z")
  end
end
