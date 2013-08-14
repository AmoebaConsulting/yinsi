module ProMotion
  class TabBarController < UITabBarController
    include ProMotion::ScreenNavigation
    include YinsiHelpers
    include Graphics

    def viewDidAppear(animated)
      super

      # Check to see if we are logged in, and if not present the login screen modal
      if User.count == 0
        self.open_modal(LoginScreen)
      end
    end

    def viewDidLoad
      super

      # Style the TabBar
      UITabBar.appearanceWhenContainedIn(TabBarController, nil)
        .setBackgroundImage(color_image(stylesheet_var(:grey_dark), self.tabBar.bounds))
        .setSelectedImageTintColor(stylesheet_var(:green_medium))
    end

  end
end