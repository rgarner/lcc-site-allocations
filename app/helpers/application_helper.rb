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
end
