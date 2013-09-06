module MotionModel
  module Validatable
    def validate_unique(field, value, setting)
      if self.class.where(field).eq(value).count > 0
        return false
      end
      true
    end
  end
end