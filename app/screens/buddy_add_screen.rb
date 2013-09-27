class BuddyAddScreen < PM::Screen
  include YinsiHelpers
  include AnimatedTextFields

  title "+ CONTACT"
  #title 'Add Buddy'

  stylesheet :buddy

  def on_init
    layout (self.view, :root) do

      @username = subview(UITextField, :username, delegate: self)
      @add_button = subview(FUIButton, :add_button)

      dismiss_keyboard_on_tap
      animate_text_field(@username)
      @add_button.on(:touch) { submit }

    end
  end

  def on_appear
    reveal_inputs
  end

  def will_disappear
    reset_inputs
  end

  def reveal_inputs
    @username.slide(:right, 260, duration: 0.5)

    @add_button.fade_in(duration: 1)
    @add_button.slide(:up, 120, duration: 1)
    @add_button.animate_to_stylename(:big_button_purple)

  end

  def reset_inputs
    @username.slide(:left, 260)
    @add_button.slide(:down, 120)
    @add_button.animate_to_stylename(:big_button)
    @add_button.fade_out


  end

  # Delegate method from username field
  def textFieldShouldReturn(text_field)
    submit
  end

  def submit
    b = Buddy.create(name: @username.text)

    if b.valid?
      close
    else
      b.error_messages.first.each do |col, error|
        App.alert(error)
      end
      @username.text = ""
    end
  end

  def back
    close
  end

end