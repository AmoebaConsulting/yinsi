class Buddy < BaseModel
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  include MotionModel::RestfulModel
  include YinsiHelpers

  columns     :name       => :string,
              :created_at => :date

  belongs_to  :user

  @primary_key = :name

  API_BUDDIES_ENDPOINT = "API".info_plist + "/api/v1/buddies.json"

  def self.download_all(&callback)
    http_query(API_BUDDIES_ENDPOINT) do |q|

      q.response do |res|
        if res.success?
          Buddy.destroy_all
          if res['buddies_count'] > 0
            res['buddies'].each do |buddy|
              b = Buddy.create_from_server name: buddy['name'], created_at: buddy['created_at']
            end
          end
        end
        callback.call(res) if callback
      end

      q.error(401) do
        App.delegate.tab_bar.logout
      end
    end
  end

  def name=(val)
    # Buddies names are immutable, that is they can only be set on creation.
    if self.send(:name).nil?
      _set_attr(:name, val)
    else
      raise "Cannot change the name of an existing buddy"
    end
  end

end