module Formotion
  class Form < Formotion::Base
    def tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)
      #cell.backgroundView = UIView.alloc.initWithFrame(cell.bounds)
      cell.stylename = :table_cell
    end

    def tableView(tableView, willDisplayHeaderView: header, forSection: section)
      header.stylename = :table_header
    end
  end
end

class RegistrationController < Formotion::FormController
  include YinsiHelpers

  stylesheet :registration

  API_REGISTER_ENDPOINT = "http://localhost:3000/api/v1/users.json"

  def init
    form = Formotion::Form.new({
      sections: [{
        rows: [
          {
            title: "Username",
            key: :name,
            placeholder: "choose a name",
            type: :string,
            auto_correction: :no,
            auto_capitalization: :none
          }, {
            title: "Password",
            key: :password,
            placeholder: "required",
            type: :string,
            secure: true
          }, {
            title: "Confirm Password",
            key: :password_confirmation,
            placeholder: "required",
            type: :string,
            secure: true
          }
        ],
      }, {
        title: "Email is completely optional, and if provided will allow you to reset your password.",
        rows: [
          {
            title: "Email",
            key: :email,
            placeholder: "optional",
            type: :email,
            auto_correction: :no,
            auto_capitalization: :none
          }
        ]
      }, {
        #title: "By clicking Register you are indicating that you have read and agreed to the terms of service",
        rows: [
          {
            title: "Register",
            type: :submit,
          }
        ]
      }] #Sections
    })

    form.on_submit do
      self.register
    end
    super.initWithForm(form)
  end

  def layoutDidLoad
    self.view.stylename = :root
    self.tableView.backgroundView = nil
    UILabel.appearanceWhenContainedIn(UITableViewHeaderFooterView, nil)
      .setTextColor(stylesheet_var(:grey)).setShadowColor(UIColor.clearColor)
      #.setFont(UIFont.systemFontOfSize(20))

  end

  def viewDidLoad
    super
    #Teacup::Appearance.new do
    #  style UILabel, when_contained_in: UITableViewHeaderFooterView,
    #        font: UIFont.systemFontOfSize(12),
    #        textColor: UIColor.whiteColor,
    #        shadowColor: UIColor.clearColor
    #end
    #Teacup::Appearance.apply # Load in Teacup's "appearance" classes
    self.title = "Register"
  end

  def register
    headers = { 'Content-Type' => 'application/json' }
    data = BW::JSON.generate({ user: {
      email: form.render[:email],
      name: form.render[:name],
      password: form.render[:password],
      password_confirmation: form.render[:password_confirmation]
    } })

    if form.render[:email].nil? ||
      form.render[:name].nil? ||
      form.render[:password].nil? ||
      form.render[:password_confirmation].nil?
      App.alert("Please complete all the fields")
    else
      if form.render[:password] != form.render[:password_confirmation]
        App.alert("Your password doesn't match confirmation, check again")
      else
        SVProgressHUD.showWithStatus("Registering new account...", maskType:SVProgressHUDMaskTypeGradient)
        BW::HTTP.post(API_REGISTER_ENDPOINT, { headers: headers , payload: data } ) do |response|
          if response.status_description.nil?
            App.alert(response.error_message)
          else
            if response.ok?
              json = BW::JSON.parse(response.body.to_str)
              App::Persistence['authToken'] = json['data']['auth_token']
              App.alert(json['info'])
              self.navigationController.dismissModalViewControllerAnimated(true)
              TasksListController.controller.refresh
            elsif response.status_code.to_s =~ /40\d/
              App.alert("Registration failed")
            else
              App.alert(response.to_str)
            end
          end
          SVProgressHUD.dismiss
        end
      end
    end
  end

  def dismiss
    self.presentingViewController.dismissModalViewControllerAnimated(true)
  end

  def self.controller
    @controller ||= RegistrationController.alloc.init
  end
end