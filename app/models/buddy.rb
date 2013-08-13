class Buddy
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter

  columns     :name       => :string,
              :created_at => :date

  belongs_to  :user
end