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

  ##
  # Create a Chart.js dataset by the given +type+
  # Requires a by_score hash grouped by score, e.g.
  # { -18: [{coalesced_green_brown: 'green', count: 6}, {coalesced_green_brown: 'brown', count: 1}]}
  # { -17: [{coalesced_green_brown: 'green', count: 7}, {coalesced_green_brown: 'brown', count: 2}]}
  DEFAULT_ALPHA = 0.75

  def distribution_dataset(type, by_score)
    {
      label:       type.titleize,
      fillColor:   named_to_rgba(doughnut_color(type),                  alpha: DEFAULT_ALPHA),
      strokeColor: named_to_rgba(doughnut_color(type, highlight: true), alpha: DEFAULT_ALPHA),
      pointColor:  named_to_rgba(doughnut_color(type, highlight: true), alpha: DEFAULT_ALPHA),
      pointStrokeColor: "white",
      data: by_score.each_pair.map do |score, rows|
        row = rows.find {|row| row.coalesced_green_brown == type}
        row.present? && score.present? ? row.count : 0
      end
    }.to_json.html_safe
  end
end
