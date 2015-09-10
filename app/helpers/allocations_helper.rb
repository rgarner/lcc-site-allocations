module AllocationsHelper
  def allocation_filter_link(text, name, value, options = {} )
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

    current_scopes.delete(:by_green_status) if name == :by_policy

    case
    when current_scopes[name] == value
      # Value is already selected. Don't render a link
      content_tag(:span, markup, class: 'btn btn-default active')
    when value == :all
      # Value should be removed from the query string
      content_tag(:a, markup, class: "btn btn-default#{" active" if current_scopes[name].nil? }",
                  href: allocations_path(current_scopes.except(name)))
    else
      # Value should be added to the query string
      content_tag(:a, markup, class: options[:class] || 'btn btn-default',
                  href: allocations_path(current_scopes.merge({name => value})))
    end
  end

  def allocation_display_name(allocation)
    "#{allocation.plan_ref} #{allocation.address}"
  end

  def links_to_sites(allocation)
    allocation.sites.map do |site|
      link_to site.shlaa_ref, site_path(site)
    end.join(', ').html_safe
  end

  def show_green_brown_filter?
    current_scopes[:by_policy] =~ /HG2/i
  end

  def show_area_ha?
    current_scopes[:by_policy].nil? || current_scopes[:by_policy] =~ /HG[23]/i
  end

  def show_construction_totals?
    !show_area_ha?
  end
end
