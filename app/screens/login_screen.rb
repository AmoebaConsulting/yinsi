class LoginScreen < PM::Screen
  include AnimatedTextFields
  include YinsiHelpers

  stylesheet :login

  # will_appear runs every time the view appears
  def will_appear

  end

  # on_load runs once, during the creation of the view
  def on_load
    layout (self.view, :root) do

      @label = subview(UILabel, :title)
      @username = subview(UITextField, :username, delegate: self)
      @password = subview(UITextField, :password, delegate: self)
      @login_button = subview(UIButton, :login_button)
      @register_button = subview(UIButton, :register_button)

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

    animate_text_field(@username)
    animate_text_field(@password)

    dismiss_keyboard_on_tap

    @login_button.on(:touch) { login }
    @register_button.on(:touch) do
      self.open_modal(RegistrationScreen)
    end

  end

  # Delegate method for text fields exiting focus
  def textFieldShouldReturn(text_field)
    case text_field
      when @username
        text_field.resignFirstResponder
        @password.becomeFirstResponder
      else
        login
    end

  end

  def login
    fields = { name: @username.text, password: @password.text }
    User.login(fields) do
      dismiss
    end
  end

  def dismiss
    @login_button.off(:all)
    self.presentingViewController.dismissModalViewControllerAnimated(true)
  end

  def dismissKeyboard
    self.view.endEditing(true)
  end

  def top_level_view
    view
  end
end
