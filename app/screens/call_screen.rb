class CallScreen < PM::Screen
  include YinsiHelpers

  stylesheet :call

  def on_appear

  end
  def on_load
    set_tab_bar_item icon: font_awesome_tab_icon(:phone), title: "Call"
    self.view.stylename = :root


  end
end