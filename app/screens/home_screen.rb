class HomeScreen < PM::Screen
  include YinsiHelpers

  title "Home Screen"
  stylesheet :home

  def on_load
    set_tab_bar_item icon: font_awesome_tab_icon(:heart)
    self.view.stylename = :root

  end
end