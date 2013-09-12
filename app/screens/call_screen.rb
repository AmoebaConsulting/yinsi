class CallScreen < PM::Screen
  include YinsiHelpers

  stylesheet :call

  def on_init # only called once, ever
    set_tab_icon(:phone, "Call")
  end

  def on_load
    layout(self.view, :root) do
      @username = subview(UITextField, :username, delegate: self)
      @call_time = subview(UILabel, :call_time)
      @challenge_text = subview(ChallengeTextView, :challenge_text)
      @call_button = subview(FUIButton, :call_button)
    end

    dismiss_keyboard_on_tap
  end

  def textFieldShouldReturn
    call(@username.text) unless @username.text.empty?
  end

  def call(username)

  end
end