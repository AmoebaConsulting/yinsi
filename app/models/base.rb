class BaseModel
  class << self
    # Store the model name as a class-level var so we can access it from the base class
    def inherited(klass)
      klass.class_eval {
        @model_name = self.name
      }
    end

    def http_query(url,&block)
      builder = HttpBuilder.new
      block.call(builder)
      builder.build(url)
    end

    def observer(&callback)
      observer = App.notification_center.observe('MotionModelDataDidChangeNotification') do |notification|
        if notification.object.is_a?(Object.const_get(@model_name))
          callback.call(notification)
        end
      end

      observer
    end
  end

  def http_query(url, &block)
    self.class.http_query(url, &block)
  end
end