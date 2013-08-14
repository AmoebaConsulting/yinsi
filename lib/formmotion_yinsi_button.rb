module Formotion
  module RowType
    class YinsiButtonRow < Base
      def button?
        true
      end

      def build_cell(cell)
        cell.selectionStyle = UITableViewCellSelectionStyleNone
        cell.backgroundView = UIView.alloc.initWithFrame(cell.bounds)
        cell.backgroundView.backgroundColor = row.value[:backgroundColor]
        cell.backgroundView.layer.cornerRadius = 6

        cell.swizzle(:layoutSubviews) do
          def layoutSubviews
            old_layoutSubviews

            center = lambda {|frame, dimen|
              ((self.frame.size.send(dimen) - frame.size.send(dimen)) / 2.0)
            }

            self.textLabel.center = CGPointMake(self.frame.size.width / 2 - (Formotion::RowType::Base.field_buffer / 2), self.textLabel.center.y)
            self.detailTextLabel.center = CGPointMake(self.frame.size.width / 2 - (Formotion::RowType::Base.field_buffer / 2), self.detailTextLabel.center.y)

            self.textLabel.textColor = "white".to_color
            self.textLabel.backgroundColor = UIColor.clearColor
          end
        end

        # return nil because no UITextField added.
        nil
      end
    end
  end
end