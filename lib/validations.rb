module MotionModel
  module Validatable
    def validate_unique(field, value, setting)
      if self.class.where(field).eq(value).count > 0
        add_message(field, "#{field} must be unique")
        return false
      end
      true
    end
  end
end