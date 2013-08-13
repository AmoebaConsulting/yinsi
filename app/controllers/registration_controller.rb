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