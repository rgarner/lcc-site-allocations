module StatsHelper
  def doughnut_color(green_brown, highlight: false)
    case green_brown
    when 'green'
      highlight ? 'green' : 'darkgreen'
    when 'brown'
      highlight ? 'sienna' : 'saddlebrown'
    when 'mix'
      highlight ? 'olivedrab' : 'olive'
    end
  end
end
