module ProMotion
  class TabBarController < UITabBarController
    include ProMotion::ScreenNavigation

    def viewDidAppear(animated)
      super

      # Check to see if we are logged in, and if not present the login screen modal
      if User.count == 0
        self.open_modal(LoginScreen)
      end
    end

    def viewDidLoad
      super

      #image = Graphics::color_image(UIColor.whiteColor, tabBar.bounds)
      #tabBar.backgroundImage = image

      #image = Graphics::color_image(UIColor.whiteColor, self.view.bounds)
      #self.view.addSubview(image)

      #puts "Tab bar items: #{tabBar.items}"

      #tabBar.items.each do |item|

      #end
    end
  end
end