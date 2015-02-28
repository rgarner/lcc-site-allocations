module SitesHelper
  def total_css_class(total_score)
    case total_score
    when -58..-10 then 'very-negative'
    when -10..-1 then 'negative'
    when -0 then 'neutral'
    when 1..10 then 'positive'
    when 1..58 then 'very-positive'
      else raise ArgumentError, "#{total_score} unbanded"
    end
  end

  GREEN = <<-HTML
    <span class="glyphicon glyphicon-tree-deciduous"></span>
  HTML
  BROWN = <<-HTML
    <span class="glyphicon glyphicon-oil"></span>
  HTML

  def green_brown_glyphs(site)
    case site.green_status
    when :green then GREEN
    when :brown then BROWN
    when :mixed then GREEN + BROWN
    else
      ''
    end.html_safe
  end
end
