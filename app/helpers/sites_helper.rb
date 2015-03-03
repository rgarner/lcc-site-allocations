module SitesHelper
  def total_css_class(total_score)
    case total_score
    when -58..-10 then 'very-negative'
    when -10..-1 then 'negative'
    when -0 then 'neutral'
    when 1..10 then 'positive'
    when 11..58 then 'very-positive'
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

  def site_filter_link(text, name, value, options = {} )
    # <a class="btn btn-default" href="<%= sites_path by_green_status: 'green' %>">
    #   <span class="glyphicon glyphicon-tree-deciduous"></span>
    #   Greenfield
    # </a>
    raise ArgumentError, 'name must be a symbol' unless name.is_a?(Symbol)

    glyphs = options[:glyphs]

    markup = if glyphs.try(:any?)
               glyphs.map do |glyph|
                 content_tag :span, nil, class: "glyphicon #{glyph}"
               end.join("\n")
             else
               ''
             end
    markup = (markup + content_tag(:span, text, class: 'filter-text')).html_safe


    case
    when current_scopes[name] == value
      # Value is already selected. Don't render a link
      content_tag(:span, markup, class: 'btn btn-default active')
    when value == :all
      # Value should be removed from the query string
      content_tag(:a, markup, class: "btn btn-default#{" active" if current_scopes[name].nil? }",
                  href: sites_path(current_scopes.except(name)))
    else
      # Value should be added to the query string
      content_tag(:a, markup, class: 'btn btn-default',
                  href: sites_path(current_scopes.merge({name => value})))
    end
  end
end
