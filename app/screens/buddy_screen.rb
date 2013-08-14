class BuddyScreen < PM::Screen
  include YinsiHelpers

  stylesheet :buddy

  def on_init
    set_tab_bar_item icon: font_awesome_tab_icon(:group), title: "Buddies"
    self.view.stylename = :root
  end

end