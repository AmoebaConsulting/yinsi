class BuddyAddScreen < PM::Screen
  include YinsiHelpers

  title "Add a Buddy"

  stylesheet :buddy

  def on_init
    self.view.stylename = :root

    # You want a UIBarButtonItem initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil
    set_nav_bar_button :back, title: 'Back', style: :plain, action: :back

  end

  def back
    close saved: true # or false
  end

end