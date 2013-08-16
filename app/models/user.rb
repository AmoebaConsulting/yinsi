#
# The "User" class is used to refer to the current user. Thus, there is only one "User" at any given
# time (until we permit multiple logins). User.first will refer to the currently logged on user. For
# a user's buddy list, the "Buddy" model is used. Thus a User has_many buddies. Unlike the backend
# which has a more complex relationship between buddies and users, a buddy does not refer back to
# the user model (it is de-normalized).
#

class User < BaseModel
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

  def self.register(fields, &callback)
    SVProgressHUD.showWithStatus("Registering new account...", maskType:SVProgressHUDMaskTypeGradient)

    http_query(API_REGISTER_ENDPOINT) do |q|
      q.data[:user] = fields
      q.verb = :post

      q.response do |res|
        build_and_save_user_from_response(res) if res.success?
        callback.call(res) if callback
        SVProgressHUD.dismiss
      end

      q.error(/40[69]/) do |res|
        # 406: Username is taken (or otherwise invalid)
        # 409: Email address is already in use
        info = "Unknown registration error"
        info = res.info unless res.info.empty?
        App.alert(info)
      end

      q.error(422) do |res|
        info = "(unknown)"
        info = res.info unless res.info.empty?
        App.alert("Error: #{info}")
      end

    end


  end

  def self.login(fields, &callback)
    SVProgressHUD.showWithStatus("Logging in...", maskType:SVProgressHUDMaskTypeGradient)

    http_query(API_LOGIN_ENDPOINT) do |q|
      q.data[:user] = fields
      q.verb = :post

      q.response do |res|
        build_and_save_user_from_response(res) if res.success?
        callback.call(res) if callback
        SVProgressHUD.dismiss
      end

      q.error(/40\d/) do |res|
        info = "Login Failed"
        info = res.info unless res.info.empty?
        App.alert(info)
      end
    end
  end

  def self.build_and_save_user_from_response(res)
    User.destroy_all
    fields = res['user']
    u = User.new name:  fields['name'],
             email: fields['email'],
             created_at: fields['created_at'],
             updated_at: fields['updated_at'],
             auth_token: res['auth_token']
    u.save(:validate => false)
    u
  end

  def self.current
    User.first
  end
end