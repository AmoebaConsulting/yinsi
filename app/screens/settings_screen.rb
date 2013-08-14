class SettingsScreen < PM::Screen
  include YinsiHelpers

  stylesheet :settings

  def on_init
    set_tab_bar_item icon: font_awesome_tab_icon(:cog), title: "Settings"
    self.view.stylename = :root
  end
end