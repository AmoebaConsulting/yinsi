#
# The "User" class is used to refer to the current user. Thus, there is only one "User" at any given
# time (until we permit multiple logins). User.first will refer to the currently logged on user. For
# a user's buddy list, the "Buddy" model is used. Thus a User has_many buddies. Unlike the backend
# which has a more complex relationship between buddies and users, a buddy does not refer back to
# the user model (it is de-normalized).
#

class User
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  include MotionModel::Validatable

  columns :name        => :string,
          :email       => {type: :string, default: ''},
          :auth_token  => :string,
          :created_at  => :date,
          :updated_at  => :date

  validate :name, :presence => true
  validate :name, :length => 4..32
  validate :email, :email

  has_many    :buddies, :dependent => :destroy

  API_REGISTER_ENDPOINT = "API".info_plist + "/api/v1/users.json"
  API_LOGIN_ENDPOINT = "API".info_plist + "/api/v1/users/sessions.json"

  def self.register(fields, &block)
    data = BW::JSON.generate({ user: {
      email: fields[:email],
      name: fields[:name],
      password: fields[:password],
      password_confirmation: fields[:password_confirmation]
    } })

    SVProgressHUD.showWithStatus("Registering new account...", maskType:SVProgressHUDMaskTypeGradient)

    BW::HTTP.post(API_REGISTER_ENDPOINT, { headers: YinsiHelpers.api_headers , payload: data } ) do |response|
      SVProgressHUD.dismiss
      if response.status_description.nil?
        App.alert(response.error_message)
      else
        json = YinsiHelpers.parse_json(response.body)

        if response.ok? && json
          # Build a user object and save it
          build_and_save_user_from_json(json)
          block.call(json)
        elsif response.status_code == 406 || response.status_code == 409
          # 406: Username is taken (or otherwise invalid)
          # 409: Email address is already in use
          info = "(unknown)"
          info = json['info'] if json
          App.alert(info)
        elsif response.status_code == 422
          info = "(unknown)"
          info = json['info'] if json
          App.alert("Server Error: #{info}.")
        else
          App.alert("Unknown Failure! Try again.")
        end
      end
    end
  end

  def self.login(fields, &block)
    data = BW::JSON.generate({ user: {
      name: fields[:name],
      password: fields[:password]
    } })

    SVProgressHUD.showWithStatus("Logging in...", maskType:SVProgressHUDMaskTypeGradient)
    BW::HTTP.post(API_LOGIN_ENDPOINT, { headers: YinsiHelpers.api_headers , payload: data } ) do |response|
      puts "Response: #{response}."
      if response.status_description.nil?
        App.alert(response.error_message)
      else
        json = YinsiHelpers.parse_json(response.body)
        if response.ok? && json
          build_and_save_user_from_json(json)
          block.call(json)
        elsif response.status_code.to_s =~ /40\d/
          info = "Login Failed"
          info = json['info'] if json && json.include?('info')
          App.alert(info)
        else
          App.alert(response.to_str)
        end
      end
      SVProgressHUD.dismiss
    end
  end

  def self.build_and_save_user_from_json(json)
    User.delete_all
    u = User.new name:  json['data']['user']['name'],
             email: json['data']['user']['email'],
             created_at: json['data']['user']['created_at'],
             updated_at: json['data']['user']['updated_at'],
             auth_token: json['data']['auth_token']
    u.save(:validate => false)
    u
  end

end