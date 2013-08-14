module Graphics
  extend self

  # Creates a new UIImage object based on the given color and frame. Of course, to actually insert
  # the image into a view, you'll need to nest it within a UIImageView.
  #
  # Example: Graphics::color_image(UIColor.whiteColor, self.view.bounds)
  #
  def color_image(color, frame)
    if color.is_a?(String)
      color = color.to_color
    end

    UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
    color.setFill
    UIRectFill(frame)
    image = UIImage.UIGraphicsGetImageFromCurrentImageContext
    UIGraphicsEndImageContext()
    image
  end

  def view_from_image(image)
    UIImageView.alloc.initWithImage(image)
  end

  def gradient_layer_with_top(top_color, bottom_color, frame)
    layer = CAGradientLayer.layer
    layer.frame = frame
    layer.colors = [top_color.CGColor, bottom_color.CGColor]
    layer.startPoint = CGPointMake(0.5, 0)
    layer.endPoint = CGPointMake(0.5, 1.0)
    layer
  end

  def gradient_image_with_top(top_color, bottom_color, frame)
    layer = gradient_layer_with_top(top_color, bottom_color, frame)
    UIGraphicsBeginImageContext(layer.frame.size)
    layer.renderInContext(UIGraphicsGetCurrentContext())
    image = UIImage.UIGraphicsGetImageFromCurrentImageContext
    UIGraphicsEndImageContext()
    image
  end
end