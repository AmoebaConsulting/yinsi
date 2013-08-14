class CallScreen < PM::Screen
  include YinsiHelpers

  stylesheet :call

  def on_init
    set_tab_bar_item icon: font_awesome_tab_icon(:phone), title: "Call"
    self.view.stylename = :root
  end
end