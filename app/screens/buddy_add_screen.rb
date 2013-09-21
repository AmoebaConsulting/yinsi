class BuddyAddScreen < PM::Screen
  include YinsiHelpers
  include AnimatedTextFields

  #title "+ CONTACT"
  title 'Add Buddy'

  stylesheet :buddy

  def on_init
    layout (self.view, :root) do

      @username = subview(UITextField, :username, delegate: self)
      @add_button = subview(FUIButton, :add_button)

      #auto do
      #  metrics 'margin' => 20
      #
      #  vertical "|-75-[username(==40)]-margin-[add_button(==60)]-(>=margin)-|"
      #  horizontal "|-margin-[username]-margin-|"
      #  horizontal "|-margin-[add_button]-margin-|"
      #end

      dismiss_keyboard_on_tap
      animate_text_field(@username)
      @add_button.on(:touch) { submit }

    end
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