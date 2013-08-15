class Buddy
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  include YinsiHelpers

  columns     :name       => :string,
              :created_at => :date

  belongs_to  :user

  API_BUDDIES_ENDPOINT = "API".info_plist + "/api/v1/buddies.json"

  def self.download_all(&callback)
    BW::HTTP.get(API_BUDDIES_ENDPOINT, headers: api_headers ) do |response|
      if response.status_description.nil?
        App.alert(response.error_message)
      else
        json = parse_json(response.body)
        if response.ok? && json
          Buddy.delete_all
          if json['data']['buddies_count'] > 0
            json['data']['buddies'].each do |buddy|
              b = Buddy.new name: buddy['name'], created_at: buddy['created_at']
              b.save(:validate => false)
            end
          end
        elsif response.status_code == 401
          App.delegate.tab_bar.logout
        else
          App.alert("Unknown error occurred while trying to sync buddy list")
        end
      end
      callback.call(json) if callback
    end
  end

end