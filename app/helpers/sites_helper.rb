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
end
