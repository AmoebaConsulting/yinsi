class LoginController < UIViewController
  include AnimatedTextFields

  stylesheet :login

  layout :login do
    @label = subview(UILabel, :title)
    @username = subview(UITextField, :username, delegate: self)
    @password = subview(UITextField, :password, delegate: self)
    @login_button = subview(UIButton, :login_button)
    @register_button = subview(UIButton.custom, :register_button)

    auto do
      metrics 'margin' => 20

      vertical "|-50-[title]-75-[username]-margin-[password]-margin-[login_button(==60)]->=20-[register_button(==40)]-margin-|"
      horizontal "|-[title]-|"
      horizontal "|-margin-[username]-margin-|"
      horizontal "|-margin-[password]-margin-|"
      horizontal "|-margin-[login_button]-margin-|"
      horizontal "|-margin-[register_button]-margin-|"
    end
  end

  def layoutDidLoad
    self.view.stylename = :root
    animate_text_field(@username)
    animate_text_field(@password)
  end

  # Delegate method for text fields exiting focus
  def textFieldShouldReturn(text_field)
    case text_field
      when @username
        text_field.resignFirstResponder
        @password.becomeFirstResponder
      else
        dismiss
    end

  end

  def dismiss
    RootController.controller.dismissModalViewControllerAnimated(true)
  end


end
