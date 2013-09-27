class LoginScreen < PM::Screen
  include AnimatedTextFields
  include YinsiHelpers

  stylesheet :login

  # on_load normally runs once, during the creation of the view
  # but can run more than once if the view is unloaded (and inactive)
  # in a low-memory situation
  def on_load
    layout (self.view, :root) do

      @title = subview(UILabel, :title)
      @username = subview(UITextField, :username, delegate: self)
      @password = subview(UITextField, :password, delegate: self)
      @login_button = subview(UIButton.custom, :login_button)
      @register_button = subview(UIButton.custom, :register_button)

      #auto do
      #  metrics 'margin' => 20
      #  #metrics '2margin' => 20
      #
      #  vertical "|-50-[title]-75-[username]-margin-[password(==80)]-margin-[login_button(==30)]->=20-[register_button(==40)]-margin-|"
      #  horizontal "|-[title]-|"
      #  horizontal "|-margin-[username]-margin-|"
      #  horizontal "|[password]-margin-|"
      #  horizontal "|-margin-[login_button]-margin-|"
      #  horizontal "|-margin-[register_button]-margin-|"
      #end
    end

    animate_text_field(@username)
    animate_text_field(@password)

    dismiss_keyboard_on_tap


    # THIS WAS FOR DYNAMICALLY ENABLING/DISABLING THE LOGIN BUTTON
    #@password.on :change do
    #  puts "user has: (#{@username.hasText})"
    #  puts "pw has: (#{@password.hasText})"
    #  if @username.hasText == 1 && @password.hasText == 1
    #    @login_button.enabled = true
    #    @login_button.fade_in
    #  else
    #    @login_button.enabled = false
    #    @login_button.fade_out(opacity: 0.25)
    #  end
    #end
    #
    #@username.on :change do
    #  puts "user has: (#{@username.hasText})"
    #  puts "pw has: (#{@password.hasText})"
    #  if @password.hasText == 1 && @username.hasText == 1
    #    @login_button.enabled = true
    #    @login_button.fade_in
    #  else
    #    @login_button.enabled = false
    #    @login_button.fade_out(opacity: 0.25)
    #  end
    #end

    @login_button.on(:touch) { login }
    @register_button.on(:touch) do
      self.open_modal(RegistrationScreen)
      reset_inputs
    end

  end

  def on_appear
    reveal_inputs
  end

  def reveal_inputs
    @title.fade_in(duration: 1.5)

    @username.slide(          :right, 260, duration: 0.5)
    @password.slide(          :right, 260, duration: 0.5, delay: 0.15)

    @login_button.slide(      :up,    120, duration: 1)
    @login_button.fade_in(duration: 1)
    @login_button.animate_to_stylename(:big_button_purple, duration: 2.5)

    @register_button.slide (  :left,  230, duration: 1)
    @register_button.animate_to_stylename(:big_button_green, duration: 2.5)

  end

  def reset_inputs
    @title.fade_out
    @username.slide :left, 260
    @password.slide :left, 260
    @register_button.slide :right, 225
    @login_button.slide :down, 120

    @login_button.fade_out
    @login_button.animate_to_stylename(:big_button)
    @register_button.animate_to_stylename(:big_button)
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
    User.login(fields) do |response|
      if response.success?
        tab_titled("Call").setup_sip_agent
        dismiss
      end
    end
  end

  def dismiss
    @login_button.off(:all)
    self.presentingViewController.dismissModalViewControllerAnimated(true)
  end

  def top_level_view
    view
  end
end
