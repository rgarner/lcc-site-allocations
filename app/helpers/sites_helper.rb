module SitesHelper
  def site_display_name(site)
    "#{site.shlaa_ref}#{" #{site.address if site.address}"}"
  end

  def total_css_class(total_score)
    case total_score
    when Score::VERY_NEGATIVE then 'very-negative'
    when Score::NEGATIVE      then 'negative'
    when Score::NEUTRAL       then 'neutral'
    when Score::POSITIVE      then 'positive'
    when Score::VERY_POSITIVE then 'very-positive'
      else ''
    end
  end

  def showing_scores?
    current_scopes[:with_scores] != '0' && should_show_score_filter?
  end

  def should_show_score_filter?
    current_scopes[:by_io_rag] != 'LG'
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

  def selected_io_rag_label
    selected = RAGStatus[current_scopes[:by_io_rag]]
    selected ? selected.display_name : 'All'
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
      content_tag(:a, markup, class: options[:class] || 'btn btn-default',
                  href: sites_path(current_scopes.merge({name => value})))
    end
  end

  def site_sort_link(text, name, options = {})
    return text if options[:disable_sorting]

    # <a class="sort sort-asc" href="/sites/2062?thing=1' %>">
    #   Capacity<span class="glyphicon glyphicon-sort-by-attributes"></span>
    # </a>

    raise ArgumentError, 'name must be a symbol' unless name.is_a?(Symbol)

    current_sort_order = current_scopes[name].try(:to_sym)
    next_sort_order    = case current_sort_order
                         when :none, nil then :desc
                         when :desc then :asc
                         when :asc then :none
                         end

    href = if next_sort_order == :none
             sites_path(current_scopes.except(name))
           else
             sites_path(
               current_scopes
                 .reject {|key| key.to_s =~ /^sort_by_/}
                 .merge({name => next_sort_order})
             )
           end

    content_tag :a, class: "sort sort-#{current_sort_order}", href: href do
      case current_sort_order
      when nil, :none
        text
      when :desc
        text + content_tag(:span, nil, class: 'glyphicon glyphicon-sort-by-attributes-alt')
      when :asc
        text + content_tag(:span, nil, class: 'glyphicon glyphicon-sort-by-attributes')
      end.html_safe
    end
  end

  def feature_json(site, extra_props = {})
    RGeo::GeoJSON.encode(RGeo::GeoJSON::EntityFactory.instance.feature(
      site.boundary || site.centroid,
      nil,
      {
        name:  site.address,
        score: site.total_score,
        shlaa_ref: site.shlaa_ref,
        address: site.address,
        area_ha: site.area_ha,
        capacity: site.capacity,
        io_rag: site.io_rag,
        settlement_hierarchy: site.settlement_hierarchy,
        green_brown: site.green_brown,
        reason: site.reason
      }.reverse_merge(extra_props)
    ))
  end

  class RawJson
    def initialize(s)
      @s = s || 'null'
    end
    def to_json(*)
      @s
    end

    undef_method :as_json
  end

  def raw_json_class
    RawJson
  end
end
