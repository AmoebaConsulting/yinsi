class CallScreen < PM::Screen
  include YinsiHelpers

  stylesheet :call

  def on_init
    set_tab_icon(:phone, "Call")

    self.view.stylename = :root
  end
end