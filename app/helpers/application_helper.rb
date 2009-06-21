# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  COLOR_BY_STATUS = {
    "Open"       => "#FFF000",
    "InProgress" => "#FF3300",
    "Reopened"   => "#0000FF",
    "Resolved"   => "#FFFF00",
    "Closed"     => "#00FF00"
  }
  def color_by_status(status)
    COLOR_BY_STATUS[status] || "#C0C0C0"
  end
end
