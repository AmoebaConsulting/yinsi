class LoginTextField < UITextField
  def drawPlaceholderInRect(rect)
    "blue".to_color.setFill
    self.placeholder.drawInRect(rect, withFont: :system.uifont(50), lineBreakMode: UILineBreakModeTailTruncation, alignment: self.textAlignment)
  end
end