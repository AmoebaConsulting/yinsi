# Allows you to "adjust" objects in the REPL console
# See:https://github.com/fusionbox/sugarcube#-repl-view-adjustments
include SugarCube::Adjust

class AppDelegate < PM::Delegate
  include YinsiHelpers

  def on_load(app, options)
    # Adding Motion-Xray's UIWindow shim
    #  #self.window = Motion::Xray::XrayWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    open_tab_bar HomeScreen
    #open_tab 0

    UITabBar.appearance.backgroundImage = Graphics::color_image(stylesheet_var(:grey_dark), App.window.rootViewController.tabBar.bounds)

    #UITabBarItem.appearance.setTitlePositionAdjustment(UIOffset.new(0,-20)).setTitleTextAttributes({
    #                                                UITextAttributeFont => :system.uifont(16),
    #                                                #UITextAttributeTextShadowColor => UIColor.colorWithWhite(0.0, alpha:0.4),
    #                                                UITextAttributeTextColor => UIColor.whiteColor
    #                                              }, forState: UIControlStateNormal)


    # include the SaveUIPlugin, which is not included by default
    #  #Motion::Xray.register(Motion::Xray::SaveUIPlugin.new)

  end


  #def application(application, didFinishLaunchingWithOptions:launchOptions)
  #  @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
  #
  #  # Adding Motion-Xray's UIWindow shim
  #  #@window = Motion::Xray::XrayWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
  #
  #  @myRootController = RootController.controller
  #
  #  @tabController = UITabBarController.alloc.initWithNibName(nil, bundle: nil)
  #  @tabController.viewControllers = [@myRootController]
  #  @tabController.wantsFullScreenLayout = true
  #  @window.rootViewController = @tabController
  #  @window.makeKeyAndVisible
  #
  #
  #
  #
  #  true
  #end
  #
  #def showLoginController
  #  @myRootController.presentModalViewController(LoginController.controller, animated: true)
  #end

end
