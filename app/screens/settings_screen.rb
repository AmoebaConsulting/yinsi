class SettingsScreen < PM::Screen
  include YinsiHelpers

  stylesheet :settings

  def on_init
    set_tab_icon(:cog, "Settings")
    self.view.stylename = :root
  end
end