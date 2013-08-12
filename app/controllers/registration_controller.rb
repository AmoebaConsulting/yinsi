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
    @form = Formotion::Form.new({
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
            type: :yinsi_button
          }
        ]
      }] #Sections
    })

    @form.on_submit do
      self.register
    end
    super.initWithForm(form)
  end

  def layoutDidLoad
    self.view.setBackgroundColor(stylesheet_var(:green_medium))
    self.tableView.backgroundView = nil

    UILabel.appearanceWhenContainedIn(UITableViewHeaderFooterView, RegistrationController, nil)
      .setTextColor(stylesheet_var(:grey_dark)).setShadowColor(UIColor.clearColor)

    UITableViewCell.appearanceWhenContainedIn(RegistrationController, nil)
      .setTextColor(stylesheet_var(:grey_dark))
  end

  def viewDidLoad
    super
  end

  def register
    fields = @form.render
    headers = { 'Content-Type' => 'application/json' }
    data = BW::JSON.generate({ user: {
      email: fields[:email],
      name: fields[:name],
      password: fields[:password],
      password_confirmation: fields[:password_confirmation]
    } })

    if fields[:name].empty? ||
      fields[:password].empty? ||
      fields[:password_confirmation].empty?
      App.alert("Please complete all the required fields")
      return
    end

    if fields[:password] != fields[:password_confirmation]
      App.alert("Your password doesn't match confirmation, try again")
      return
    end

    SVProgressHUD.showWithStatus("Registering new account...", maskType:SVProgressHUDMaskTypeGradient)

    BW::HTTP.post(API_REGISTER_ENDPOINT, { headers: headers , payload: data } ) do |response|
      if response.status_description.nil?
        App.alert(response.error_message)
      else
        json = parse_json(response.body)

        if response.ok? && json
          App::Persistence['authToken'] = json['data']['auth_token']
          App.alert(json['info']) # Testing
          self.dismiss
        elsif response.status_code == 406 # Username is taken (or otherwise invalid)
          info = "(unknown)"
          info = json['info'] if json
          App.alert(info)
        elsif response.status_code == 422
          info = "(unknown)"
          info = json['info'] if json
          App.alert("Server Error: #{info}.")
        else
          App.alert("Registration failed! Try again.")
        end
      end
      SVProgressHUD.dismiss
    end

  end

  def dismiss
    self.presentingViewController.dismissModalViewControllerAnimated(true)
  end

  def self.controller
    @controller ||= RegistrationController.alloc.init
  end

  private

  def parse_json(json_str)
    begin
      return BW::JSON.parse(json_str.to_str)
    rescue
      App.alert("Error decoding data from server. Try again.")
      return false
    end
  end
end