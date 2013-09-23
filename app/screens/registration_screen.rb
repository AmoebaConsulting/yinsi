class RegistrationScreen < PM::Screen
  include YinsiHelpers
  include Graphics
  include AnimatedTextFields



  stylesheet :registration


  def on_load
    layout (self.view, :root) do

      @title = subview(UILabel, :title)

      @user_label = subview(UILabel, :user_label)
      @user_input = subview(UITextField, :user_input, delegate: self)

      @password_label = subview(UILabel, :password_label)
      @password_input = subview(UITextField, :password_input, delegate: self)

      @confirm_label = subview(UILabel, :confirm_label)
      @confirm_input = subview(UITextField, :confirm_input, delegate: self)

      @break_line = subview(UILabel, :break_line)

      @email_label = subview(UILabel, :email_label)
      @email_input = subview(UITextField, :email_input, delegate: self)
      @email_info = subview(UILabel, :email_info)

      @cancel_button = subview(UIButton.custom, :cancel_button)
      @complete_register_button = subview(UIButton.custom, :complete_register_button)


      #@user_input.animateWithDuration(2, {width: +40}, nil)


    end

    @fields = [@user_input, @password_input, @confirm_input, @email_input]

    animate_text_field(@user_input)
    animate_text_field(@password_input)
    animate_text_field(@confirm_input)
    animate_text_field(@email_input)

    dismiss_keyboard_on_tap

    @complete_register_button.on(:touch) { register }
    @cancel_button.on(:touch) do
      reset
      dismiss
      reset_reg_inputs
      reset_reg_labels
    end

  end

  def on_appear
    reveal_reg_inputs
    reveal_reg_labels
  end

  def reveal_reg_inputs
    @user_input.slide(
        :right,
        260,
        duration: 0.5
    )
    @password_input.slide(
        :right,
        260,
        delay: 0.15,
        duration: 0.5
    )
    @confirm_input.slide(
        :right,
        260,
        delay: 0.3,
        duration: 0.5
    )

    @email_input.slide(
        :right,
        260,
        delay: 1,
        duration: 0.5
    )

    @email_info.slide(
        :right,
        250,
        delay: 1,
        duration: 0.5
    )

    @cancel_button.slide(
        :left,
        300,
        duration: 1
    )
    @complete_register_button.slide(
        :left,
        214,
        duration: 1
    )
  end

  def reveal_reg_labels
    @user_label.slide(
        :left,
        310,
        duration: 0.5
    )
    @password_label.slide(
        :left,
        310,
        delay: 0.15,
        duration: 0.5
    )
    @confirm_label.slide(
        :left,
        310,
        delay: 0.3,
        duration: 0.5
    )

    @email_label.slide(
        :left,
        310,
        delay: 1,
        duration: 0.5
    )
  end

  def reset_reg_inputs
    @user_input.slide :left, 260
    @password_input.slide :left, 260
    @confirm_input.slide :left, 260
    @email_input.slide :left, 260
    @email_info.slide :left, 250
    @cancel_button.slide :right, 300
    @complete_register_button.slide :right, 214
  end

  def reset_reg_labels
    @user_label.slide :right, 310
    @password_label.slide :right, 310
    @confirm_label.slide :right, 310
    @email_label.slide :right, 310
  end

  def register

    fields = {
      name: @user_input.text,
      password: @password_input.text,
      password_confirmation: @confirm_input.text,
      email: @email_input.text
    }

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

    User.register(fields) do |response|
      # Dismiss the login & registration if it's successful
      self.presentingViewController.dismiss if response.success?
    end
  end

  def dismiss
    self.presentingViewController.dismissModalViewControllerAnimated(true)
  end

  def reset
    @fields.each do |f|
      f.text = ''
    end
  end

  def textFieldShouldReturn(text_field)
    index = @fields.index(text_field)
    if index == @fields.length - 1
      register
    else
      text_field.resignFirstResponder
      @fields[index + 1].becomeFirstResponder
    end

  end

end