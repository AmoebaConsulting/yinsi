class HomeScreen < PM::Screen
  include YinsiHelpers

  stylesheet :home

  def on_appear

  end
  def on_load
    set_tab_bar_item icon: font_awesome_tab_icon(:heart), title: "Home Screen"
    self.view.stylename = :root


  end
end