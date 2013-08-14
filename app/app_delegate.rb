# Allows you to "adjust" objects in the REPL console
# See:https://github.com/fusionbox/sugarcube#-repl-view-adjustments
include SugarCube::Adjust

class AppDelegate < PM::Delegate
  include YinsiHelpers

  def on_load(app, options)
    # Adding Motion-Xray's UIWindow shim
    #  #self.window = Motion::Xray::XrayWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    open_tab_bar HomeScreen, RegistrationScreen
    #open_tab 0

    # include the SaveUIPlugin, which is not included by default
    #  #Motion::Xray.register(Motion::Xray::SaveUIPlugin.new)

  end

end
