module ApplicationHelper
  def present(model)
    klass = "#{model.class}Presenter".constantize
    presenter = klass.new(model)
    yield(presenter) if block_given?
    presenter
  end
end
