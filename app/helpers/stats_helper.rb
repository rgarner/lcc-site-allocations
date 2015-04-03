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

  R,G,B,A = 0,1,2,3
  def named_to_rgba(named, alpha: 1.0)
    c = Sass::Script::Value::Color::COLOR_NAMES[named] or
      raise ArgumentError, "#{named} is an imaginary color"

    c[A] = alpha
    "rgba(#{c[R]},#{c[G]},#{c[B]},#{c[A]})"
  end
end
