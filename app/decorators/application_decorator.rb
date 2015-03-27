class ApplicationDecorator
  include ActionView::Helpers
  include Rails.application.routes.url_helpers

  attr_accessor :model

  def initialize(model)
    @model = model
  end

  def method_missing(method_name, *args, &block)
    if model.respond_to?(method_name)
      model.send(method_name, *args)
    else  
      super(method_name, *args, &block)
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    if model.respond_to?(method_name)
      true
    else
      super(method_name, include_private)
    end
  end
end