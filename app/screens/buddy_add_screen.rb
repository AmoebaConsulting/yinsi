class BuddyAddScreen < PM::Screen
  include YinsiHelpers
  include AnimatedTextFields

  title "Add a Buddy"

  stylesheet :buddy

  def on_init
    layout (self.view, :root) do

      @username = subview(UITextField, :username, delegate: self)
      @add_button = subview(FUIButton, :add_button)

      auto do
        metrics 'margin' => 20

        vertical "|-75-[username(==60)]-margin-[add_button(==60)]-(>=margin)-|"
        horizontal "|-margin-[username]-margin-|"
        horizontal "|-margin-[add_button]-margin-|"
      end

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
    puts "Submitting"
  end

  def back
    close
  end

end