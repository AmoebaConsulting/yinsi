class BuddyTableCell < UITableViewCell

  include Teacup::Layout
  stylesheet :buddy

  attr_accessor :missed_call, :total_calls, :last_call, :date_added

  # This method is used by ProMotion to instantiate cells.
  def initWithStyle(style_name, reuseIdentifier: reuseIdentifier)
    super
    setup_subviews_and_styles
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

  def setup_subviews_and_styles
    self.textLabel.stylename = :buddy_name

    layout(self, :buddy_cell) do
      layout(self.contentView) do
        self.total_calls = subview UILabel, :buddy_total_calls
        self.last_call = subview UILabel, :buddy_last_call
        self.date_added = subview UILabel, :buddy_date_added
      end

    end

  end

end