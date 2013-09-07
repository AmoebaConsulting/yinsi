module MotionModel
  module Validatable
    def validate_unique(field, value, setting)
      results = self.class.where(field).eq(value).all

      results.each do |record|
        if record != self
          add_message(field, "#{field} must be unique")
          return false
        end
      end

      true
    end
  end
end