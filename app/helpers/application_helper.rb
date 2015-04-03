module ApplicationHelper
  def present(model)
    klass = "#{model.class}Presenter".constantize
    presenter = klass.new(model)
    yield(presenter) if block_given?
    presenter
  end

  def nav_link(active, name, options = {}, html_options = {}, &block)
    li_options = active ? { class: 'active' } : {}
    content_tag :li, li_options do
      link_to name, options, html_options, &block
    end
  end

  ##
  # Twitter bootstrap-flavour tabs.
  # Produce a <ul class="nav nav-tabs">
  # with list items with links in them.
  # e.g.
  #
  #   +bootstrap_flavour_tabs(
  #      {
  #        'Edit'    => edit_path,
  #        'History' => history_path
  #      }, active: 'Edit'
  #    )
  def bootstrap_flavour_tabs(titles_to_links, options)
    content_tag :ul, class: 'nav nav-tabs' do
      titles_to_links.inject('') do |result, title_link|
        title, href = title_link[0], title_link[1]
        active      = options[:active] == title
        li_opts     = active ? { class: 'active' } : {}

        result << content_tag(:li, li_opts) do
          link_to(title, active ? '#' : href)
        end
      end.html_safe
    end
  end
end
