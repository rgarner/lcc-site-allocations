module HasTextBasedGreenStatus
  def green_status
    case green_brown
    when /mix/i then
      :mixed
    when /greenfield/i then
      :green
    when /brownfield/i then
      :brown
    else
      nil
    end
  end
end
