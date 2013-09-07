class Buddy < BaseModel
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  include MotionModel::Validatable
  include MotionModel::RestfulModel
  include YinsiHelpers

  columns     :name       => :string,
              :created_at => :date

  validate    :name, :unique => true
  validate    :name, :length => 4..32

  primary_key :name

  collection_uri "API".info_plist + "/api/v1/buddies.json"
  element_uri "API".info_plist + "/api/v1/buddies/:primary_key.json"

  restful_errors :save => {404 => "User not found", 406 => "Buddy already exists"}

  def self.download_all(&callback)
    http_query(collection_uri) do |q|

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