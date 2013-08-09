class LoginController < UIViewController
  include AnimatedTextFields

  stylesheet :login

  layout :login do
    @label = subview(UILabel, :title)
    @username = subview(UITextField, :username)
    @password = subview(UITextField, :password)
    @login = subview(UIButton, :login)
    @register = subview(UIButton.custom, :register)

    auto do
      metrics 'margin' => 20

      vertical "|-50-[title]-75-[username]-margin-[password]-margin-[login(==60)]->=20-[register(==40)]-margin-|"
      horizontal "|-[title]-|"
      horizontal "|-margin-[username]-margin-|"
      horizontal "|-margin-[password]-margin-|"
      horizontal "|-margin-[login]-margin-|"
      horizontal "|-margin-[register]-margin-|"
    end
  end

  def layoutDidLoad
    self.view.stylename = :root
    animate_text_field(@username)
    animate_text_field(@password)
  end



  #def push_settings
  #  @settings = SettingsController.new
  #  self.navigationController << @settings
  #end

  def dismiss
    RootController.controller.dismissModalViewControllerAnimated(true)
  end


end
