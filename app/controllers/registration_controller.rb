class RegistrationController < Formotion::FormController
  include YinsiHelpers

  stylesheet :registration

  def init
    select_style = :none

    @form = Formotion::Form.new({
      sections: [{
        rows: [
          {
            title: "Username",
            key: :name,
            placeholder: "choose a name",
            type: :string,
            auto_correction: :no,
            auto_capitalization: :none,
            selection_style: select_style
          }, {
            title: "Password",
            key: :password,
            placeholder: "required",
            type: :string,
            secure: true,
            selection_style: select_style
          }, {
            title: "Confirm Password",
            key: :password_confirmation,
            placeholder: "required",
            type: :string,
            secure: true,
            selection_style: select_style
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
            auto_capitalization: :none,
            selection_style: select_style
          }
        ]
      }, {
        rows: [
          {
            title: "Register",
            type: :yinsi_button,
            value: {backgroundColor: stylesheet_var(:grey_dark)}
          }
        ]
      }, {
        rows: [
          {
            title: "Cancel",
            type: :yinsi_button,
            value: {backgroundColor: stylesheet_var(:green_medium)}
          }
        ]

      }] #Sections
    })

    @form.sections[2].rows[0].on_tap do |row| # Submit button
      @form.submit
    end

    @form.sections[3].rows[0].on_tap do |row| # Cancel button
      @form.reset
      self.dismiss
    end

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

    if !fields[:password].length.between?(8, 128)
      App.alert("Your password must be greater than 8 characters")
      return
    end

    User.register(fields) do
      # Dismiss the login & registration if it's successful
      self.presentingViewController.dismiss
    end
  end

  def dismiss
    self.presentingViewController.dismissModalViewControllerAnimated(true)
  end

  def self.controller
    @controller ||= RegistrationController.alloc.init
  end

end