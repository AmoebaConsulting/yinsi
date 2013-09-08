class StyleableTableCell < UITableViewCell

  # This method is used by ProMotion to instantiate cells.
  def initWithStyle(style_name, reuseIdentifier: reuseIdentifier)
    super
    stylish
    self
  end

  # A delegate method when the user clicks the Row(it's blue by default)
  #def setHighlighted(highlighted, animated: animated)
  #  if highlighted
  #    self.backgroundColor = UIColor.redColor
  #  else
  #    self.backgroundColor = UIColor.whiteColor
  #  end
  #end

  def stylish
    #self.backgroundColor = UIColor.whiteColor
    #self.selectionStyle = UITableViewCellSelectionStyleNone
    self.stylename = :table_cell
    self.textLabel.stylename = :table_cell_title
  end

  def layoutSubviews
    super
    #self.imageView.frame = CGRectMake(10, 10, 50, 50)
    #self.textLabel.frame = CGRectMake(70, 10, 240, 20)
    #detailTextLabelFrame = CGRectOffset(self.textLabel.frame, 0, 25);
    #detailTextLabelFrame.size.height = self.class.heightForCellWithUser(self.user) - 45
    #self.detailTextLabel.frame = detailTextLabelFrame
  end
end